#!/bin/bash
# Build Lambda deployment package

echo "Building Lambda deployment package..."

cd "$(dirname "$0")/.." || exit

# Remove old deployment package if exists
rm -f deployment.zip

# Create deployment package
cd src || exit
zip -r ../deployment.zip index.mjs

cd ..
echo "Deployment package created: deployment.zip"
echo "Size: $(du -h deployment.zip | cut -f1)"
