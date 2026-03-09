export const handler = async (event) => {
  try {
      // Validate required environment variables
      const {
          TENANT_ID,
          CLIENT_ID,
          CLIENT_SECRET,
          SENDER_USER_ID,
      } = process.env;

      const missingVars = [];
      if (!TENANT_ID) missingVars.push("TENANT_ID");
      if (!CLIENT_ID) missingVars.push("CLIENT_ID");
      if (!CLIENT_SECRET) missingVars.push("CLIENT_SECRET");
      if (!SENDER_USER_ID) missingVars.push("SENDER_USER_ID");

      if (missingVars.length > 0) {
          throw new Error(`Missing required environment variables: ${missingVars.join(", ")}`);
      }

      // Parse event payload - distinguish between Function URL (HTTP) and direct invocation
      let payload;

      // Function URL invocations have requestContext and body is a JSON string
      if (event.requestContext && event.body) {
          // Function URL (HTTP) invocation
          payload = JSON.parse(event.body);
      } else {
          // Direct Lambda invocation - event is the payload itself
          payload = event;
      }

      console.log('Invocation type:', event.requestContext ? 'Function URL (HTTP)' : 'Direct');
      console.log('Parsed payload:', JSON.stringify(payload));

      if (!payload.to) {
          throw new Error("Missing 'to' field in event payload. Please provide a recipient email address.");
      }

      console.log(`Sending email to: ${payload.to}`);

      // Get access token from Microsoft
      const tokenRes = await fetch(
          `https://login.microsoftonline.com/${TENANT_ID}/oauth2/v2.0/token`,
          {
              method: "POST",
              headers: { "Content-Type": "application/x-www-form-urlencoded" },
              body: new URLSearchParams({
                  client_id: CLIENT_ID,
                  client_secret: CLIENT_SECRET,
                  scope: "https://graph.microsoft.com/.default",
                  grant_type: "client_credentials",
              }),
          }
      );

      if (!tokenRes.ok) {
          const errorText = await tokenRes.text();
          throw new Error(`Token request failed (${tokenRes.status}): ${errorText}`);
      }

      const tokenData = await tokenRes.json();
      if (!tokenData.access_token) {
          throw new Error("Failed to get access token: " + JSON.stringify(tokenData));
      }

      console.log("Access token obtained successfully");

      // Build email message
      const message = {
          subject: payload.subject || "Email from Lambda",
          body: {
              contentType: payload.html ? "HTML" : "Text",
              content: payload.html || payload.text || payload.body || "No content provided",
          },
          toRecipients: Array.isArray(payload.to)
              ? payload.to.map(email => ({ emailAddress: { address: email } }))
              : [{ emailAddress: { address: payload.to } }],
      };

      // Add attachments if provided
      if (payload.attachments && payload.attachments.length > 0) {
          message.attachments = payload.attachments.map(att => ({
              '@odata.type': '#microsoft.graph.fileAttachment',
              name: att.filename || att.name,
              contentType: att.contentType || 'application/octet-stream',
              contentBytes: att.contentBytes || att.content,
          }));
      }

      // Send email via Microsoft Graph API
      const graphRes = await fetch(
          `https://graph.microsoft.com/v1.0/users/${SENDER_USER_ID}/sendMail`,
          {
              method: "POST",
              headers: {
                  Authorization: `Bearer ${tokenData.access_token}`,
                  "Content-Type": "application/json",
              },
              body: JSON.stringify({ message, saveToSentItems: true }),
          }
      );

      if (!graphRes.ok) {
          const err = await graphRes.text();
          throw new Error(`Graph API error (${graphRes.status}): ${err}`);
      }

      console.log("Email sent successfully");

      return {
          statusCode: 200,
          body: JSON.stringify({
              message: "Email sent successfully",
              recipient: payload.to
          }),
      };
  } catch (err) {
      console.error("Error sending email:", err.message);
      return {
          statusCode: 500,
          body: JSON.stringify({ error: err.message }),
      };
  }
};
