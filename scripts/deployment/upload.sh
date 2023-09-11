#!/bin/bash

echo "upload bundle..."

NAME=$(git rev-parse --short $GITHUB_SHA)

echo $NAME
echo $GITHUB_EVENT_NAME

echo "BUNDLE_NAME=$NAME" >> $GITHUB_OUTPUT
