#!/bin/bash

echo "$COMMIT_MESSSAGE"

PAYLOAD='{
    "@type": "MessageCard",
    "@context": "https://schema.org/extensions",
    "summary": "Despliegue",
    "themeColor": "009f4a",
    "title": "'$REPOSITORY'",
    "sections": [{
      "activityTitle": "'$(echo "$COMMIT_MESSAGE" | sed "s/\[/\\[/g; s/\]/\\]/g")'",
      "activitySubtitle": "Por '$TRIGGERING_ACTOR'", 
      "facts": [{
        "name": "Bundle     ",
        "value": "'$BUNDLE_NAME'"
      },
      {
        "name": "Versión    ",
        "value": "'$DEPLOYED_VERSION'"
      },
      {
        "name": "PageBuilder",
        "value": "'$PAGEBUILDER_VERSION'"
      }]
    }],
    "potentialAction": [{
      "@type": "OpenUri",
      "name": "Ver workflow",
      "targets": [{
        "os": "default",
        "uri": "'$SERVER_URL'/'$REPOSITORY'/actions/runs/'$RUN_ID'"
      }]
    },'$([ ! -z "$PULL_REQUEST_NUMBER" ] && echo '{
      "@type": "OpenUri",
      "name": "Ver pull request",
      "targets": [{
        "os": "default",
        "uri": "'$SERVER_URL'/'$REPOSITORY'/pull/'$PULL_REQUEST_NUMBER'"
      }]
    },')'
    {
      "@type": "OpenUri",
      "name": "Ver despliegue",
      "targets": [{
        "os": "default",
        "uri": "'$DEPLOYMENT_URL'"
      }]
    }]
  }'

echo "$PAYLOAD"