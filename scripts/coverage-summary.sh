#!/bin/bash

#COVERAGE_THRESHOLD="65,85"

TOTAL_COVERAGE=$(jq '[.total[] | if .pct == "Unknown" then 0 else .pct end] | add / length | tonumber | round' $PWD/coverage/coverage-summary.json)

IFS=', ' read -r -a THRESHOLD <<< "$COVERAGE_THRESHOLD"

if [ "$TOTAL_COVERAGE" -lt ${THRESHOLD[0]} ]; then
    STATUS="red"
elif [ "$TOTAL_COVERAGE" -gt ${THRESHOLD[0]} -a "$TOTAL_COVERAGE" -lt ${THRESHOLD[1]} ]; then
    STATUS="yellow"
else
    STATUS="green"
fi

OUTPUT="Total | Lines | Statements | Functions | Branches"
OUTPUT+="\n"
OUTPUT+=":--- | :--- | :--- | :--- | :---"
OUTPUT+="\n"
OUTPUT+="![Coverage](https://badgers.space/badge/Coverage/${TOTAL_COVERAGE}%25/${STATUS}) | "
OUTPUT+=$(jq -r '[
  "**\(.total.lines.pct | tonumber | round)** (\(.total.lines.covered)/\(.total.lines.total))",
  "**\(.total.statements.pct | tonumber | round)** (\(.total.statements.covered)/\(.total.statements.total))",
  "**\(.total.functions.pct | tonumber | round)** (\(.total.functions.covered)/\(.total.functions.total))",
  "**\(.total.branches.pct | tonumber | round)** (\(.total.branches.covered)/\(.total.branches.total))"
] | map(tostring) | join(" | ")' $PWD/coverage/coverage-summary.json)
OUTPUT+="\n\n"
OUTPUT+="_Minimum allowed coverage is \`${THRESHOLD[0]}%\`_"

echo -e "$OUTPUT" >> $GITHUB_STEP_SUMMARY