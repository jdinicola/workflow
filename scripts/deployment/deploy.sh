#!/bin/bash

echo "deploy service..."
echo "$BUNDLE_NAME"
echo "$DEPLOY_TOKEN"
echo "$DEPLOY_API_URL"
echo "$PAGEBUILDER_VERSION"

echo "DEPLOYED_VERSION=123" >> $GITHUB_OUTPUT
