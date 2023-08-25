#!/bin/bash

TOTAL_COVERAGE=$(jq '[.total[] | if .pct == "Unknown" then 0 else .pct end] | add / length | tonumber | round' $PWD/coverage/coverage-summary.json)

IFS=', ' read -r -a THRESHOLD <<< "$COVERAGE_THRESHOLD"

if [ "$TOTAL_COVERAGE" -lt ${THRESHOLD[0]} ]; then
    STATUS="red"
elif [ "$TOTAL_COVERAGE" -gt ${THRESHOLD[0]} -a "$TOTAL_COVERAGE" -lt ${THRESHOLD[1]} ]; then
    STATUS="yellow"
else
    STATUS="green"
fi

OUTPUT="![Coverage](https://badgers.space/badge/Coverage/${TOTAL_COVERAGE}%25/${STATUS})"
OUTPUT+="\n\n"
OUTPUT+=$(jq -r '["Metric", "Total", "Covered", "Skipped", "%"],
[":---", ":---", ":---", ":---", ":---"],
["Lines", .total.lines.total, .total.lines.covered, .total.lines.skipped, (.total.lines.pct | tonumber | round)],  
 ["Statements", .total.statements.total, .total.statements.covered, .total.statements.skipped, (.total.statements.pct | tonumber | round)],  
 ["Functions", .total.functions.total, .total.functions.covered, .total.functions.skipped, (.total.functions.pct | tonumber | round)],  
 ["Branches", .total.branches.total, .total.branches.covered, .total.branches.skipped, (.total.branches.pct  | tonumber | round)] | map(tostring) | join(" | ")' $PWD/coverage/coverage-summary.json)
OUTPUT+="\n\n"
OUTPUT+="_Minimum allowed coverage is \`${THRESHOLD[0]}%\`_"

echo -e "$OUTPUT" >> $GITHUB_STEP_SUMMARY