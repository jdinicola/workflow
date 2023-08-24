#!/bin/bash

TOTAL_COVERAGE=$(jq '[.total[] | if .pct == "Unknown" then 0 else .pct end] | add / length | tonumber | round' ../coverage/coverage-summary.json)

IFS=', ' read -r -a THRESHOLD <<< "$COVERAGE_THRESHOLD"

if [ "$TOTAL_COVERAGE" -lt ${THRESHOLD[0]} ]; then
    STATUS="red"
elif [ "$TOTAL_COVERAGE" -gt ${THRESHOLD[0]} -a "$TOTAL_COVERAGE" -lt ${THRESHOLD[1]} ]; then
    STATUS="yellow"
else
    STATUS="green"
fi

OUTPUT="### Code coverage summary"
OUTPUT+="![Coverage](https://badgers.space/badge/Coverage/${TOTAL_COVERAGE}%25/${STATUS})" && \
jq -r '["Metric", "Total", "Covered", "Skipped", "%"],
["---", "---", "---", "---", "---"],
["Lines", .total.lines.total, .total.lines.covered, .total.lines.skipped, .total.lines.pct],  
 ["Statements", .total.statements.total, .total.statements.covered, .total.statements.skipped, .total.statements.pct],  
 ["Functions", .total.functions.total, .total.functions.covered, .total.functions.skipped, .total.functions.pct],  
 ["Branches", .total.branches.total, .total.branches.covered, .total.branches.skipped, .total.branches.pct] | map(tostring) | join(" | ")' coverage/coverage-summary.json
OUTPUT+=" "
OUTPUT+="_Minimum allowed coverage is \`${THRESHOLD[0]}%\`_"

echo "$OUTPUT" >> $GITHUB_STEP_SUMMARY