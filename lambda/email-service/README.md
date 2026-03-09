# Lambda Email Service

AWS Lambda function for sending emails via Microsoft Graph API.

## Features

- Sends emails using Microsoft Graph API
- Supports HTML and plain text emails
- Handles attachments
- No external dependencies (uses native Node.js fetch)
- Proper error handling and logging

## Environment Variables

Configure these in the AWS Lambda console:

| Variable | Description | Example |
|----------|-------------|---------|
| `TENANT_ID` | Azure AD Tenant ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `CLIENT_ID` | Azure App Registration Client ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `CLIENT_SECRET` | Azure App Registration Client Secret | `your-client-secret` |
| `SENDER_USER_ID` | Email address of the sender | `noreply@yourdomain.com` |

## Deployment

### Option 1: Using AWS CLI

1. **Create deployment package:**
   ```powershell
   cd lambda/email-service
   Compress-Archive -Path index.mjs,package.json -DestinationPath lambda-email-service.zip -Force
   ```

2. **Create or update Lambda function:**
   ```powershell
   # Create new function
   aws lambda create-function `
     --function-name email-service `
     --runtime nodejs20.x `
     --role arn:aws:iam::YOUR_ACCOUNT_ID:role/YOUR_LAMBDA_ROLE `
     --handler index.handler `
     --zip-file fileb://lambda-email-service.zip `
     --timeout 30 `
     --memory-size 256

   # Or update existing function
   aws lambda update-function-code `
     --function-name email-service `
     --zip-file fileb://lambda-email-service.zip
   ```

3. **Set environment variables:**
   ```powershell
   aws lambda update-function-configuration `
     --function-name email-service `
     --environment "Variables={TENANT_ID=your-tenant-id,CLIENT_ID=your-client-id,CLIENT_SECRET=your-client-secret,SENDER_USER_ID=noreply@yourdomain.com}"
   ```

### Option 2: Using PowerShell Script

Run the included deployment script:

```powershell
.\deploy.ps1 -FunctionName email-service -RoleArn arn:aws:iam::YOUR_ACCOUNT_ID:role/YOUR_LAMBDA_ROLE
```

### Option 3: Using AWS Console

1. Navigate to AWS Lambda console
2. Create a new function or select existing one
3. Upload `lambda-email-service.zip`
4. Set runtime to Node.js 20.x
5. Set handler to `index.handler`
6. Configure environment variables
7. Set timeout to 30 seconds
8. Set memory to 256 MB

## Setting Up Function URL

To enable HTTP invocation:

1. Go to your Lambda function in AWS Console
2. Click on "Configuration" tab
3. Select "Function URL"
4. Click "Create function URL"
5. Choose auth type:
   - **NONE** - Public access (use with caution)
   - **AWS_IAM** - Requires AWS credentials (recommended)
6. Copy the function URL (e.g., `https://abc123.lambda-url.us-east-1.on.aws/`)
7. Add this URL to your application's `.env` file as `LAMBDA_EMAIL_SERVICE_URL`

## Event Payload Format

The Lambda function accepts the following payload:

```json
{
  "to": "recipient@example.com",
  "subject": "Email Subject",
  "html": "<h1>HTML Content</h1>",
  "text": "Plain text content",
  "attachments": [
    {
      "filename": "document.pdf",
      "contentType": "application/pdf",
      "contentBytes": "base64-encoded-content"
    }
  ]
}
```

### Fields

- `to` (required): String or array of email addresses
- `subject` (optional): Email subject line
- `html` (optional): HTML email content
- `text` (optional): Plain text email content (used if `html` is not provided)
- `attachments` (optional): Array of attachment objects

## Testing

### Test via AWS Console

1. Go to Lambda function in AWS Console
2. Click "Test" tab
3. Create test event with sample payload:
   ```json
   {
     "to": "test@example.com",
     "subject": "Test Email",
     "text": "This is a test email"
   }
   ```
4. Click "Test" button

### Test via Function URL

```powershell
$body = @{
    to = "test@example.com"
    subject = "Test Email"
    text = "This is a test email"
} | ConvertTo-Json

Invoke-RestMethod -Uri "YOUR_FUNCTION_URL" -Method Post -Body $body -ContentType "application/json"
```

### Test from Application

Use the test script in your application:

```powershell
cd api
npm run test:lambda-email
```

## Monitoring

- **CloudWatch Logs**: View logs in CloudWatch Logs console
- **Metrics**: Monitor invocations, errors, and duration in CloudWatch Metrics
- **X-Ray**: Enable X-Ray tracing for detailed performance analysis

## Troubleshooting

### Common Issues

1. **Missing environment variables**
   - Verify all required environment variables are set in Lambda configuration

2. **Token request failed**
   - Check Azure AD credentials
   - Verify app registration has correct permissions

3. **Graph API error**
   - Ensure `SENDER_USER_ID` is correct
   - Verify the sender has permission to send emails
   - Check recipient email addresses are valid

4. **Timeout errors**
   - Increase Lambda timeout (default: 3s, recommended: 30s)

## Security Best Practices

1. **Use IAM authentication** for Function URL
2. **Store secrets in AWS Secrets Manager** instead of environment variables
3. **Enable CloudWatch Logs encryption**
4. **Use VPC** if accessing internal resources
5. **Implement rate limiting** to prevent abuse
6. **Monitor CloudWatch alarms** for unusual activity

## Cost Optimization

- Lambda free tier: 1M requests/month
- Typical email send: ~200ms execution time
- Memory: 256 MB is sufficient
- Estimated cost: $0.20 per 1000 emails (beyond free tier)
