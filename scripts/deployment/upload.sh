#!/bin/bash

echo "upload bundle..."

[[ $GITHUB_EVENT_NAME = 'workflow_dispatch' ]] && NAME="wd_$GITHUB_RUN_ID" || NAME="$(git rev-parse --short $GITHUB_SHA)"

echo $NAME

echo "BUNDLE_NAME=$NAME" >> $GITHUB_OUTPUT
