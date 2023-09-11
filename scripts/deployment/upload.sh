#!/bin/bash

echo "upload bundle..."

NAME=$(git rev-parse --short $GITHUB_SHA)

[[ $GITHUB_EVENT_NAME = 'workflow_dispatch' ]] && NAME="$GITHUB_RUN_ID" || NAME="$(git rev-parse --short $GITHUB_SHA)"

echo $NAME

echo "BUNDLE_NAME=$NAME" >> $GITHUB_OUTPUT
