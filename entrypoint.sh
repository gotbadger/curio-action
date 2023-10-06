#!/bin/bash

# Filter out any empty args
args=$(for var in "$@"; do echo "$var";done | grep =.)
ORIGIN_URL=$(git -C . remote get-url origin)

echo "============================================================="
echo "SHA=$SHA"
echo "ORIGIN_URL=$ORIGIN_URL"
echo "CURRENT_BRANCH=$CURRENT_BRANCH"
echo "DIFF_BASE_BRANCH=$DIFF_BASE_BRANCH"
echo "DEFAULT_BRANCH=$DEFAULT_BRANCH"
echo "============================================================="

RULE_BREACHES=`docker run --rm -e SHA=$SHA -e "ORIGIN_URL=$ORIGIN_URL" -e "CURRENT_BRANCH=$CURRENT_BRANCH" -e DIFF_BASE_BRANCH=$DIFF_BASE_BRANCH -e DEFAULT_BRANCH=$DEFAULT_BRANCH -e "GITHUB_TOKEN=$GITHUB_TOKEN" -v ./:/tmp/scan bearer/bearer:canary-amd64 scan /tmp/scan --host=my.staging.bearer.sh --debug --exit-code=0 ${args//$'\n'/ }`
SCAN_EXIT_CODE=$?

echo "::debug::$RULE_BREACHES"

EOF=$(dd if=/dev/urandom bs=15 count=1 status=none | base64)

echo "rule_breaches<<$EOF" >> $GITHUB_OUTPUT
echo "$RULE_BREACHES" >> $GITHUB_OUTPUT
echo "$EOF" >> $GITHUB_OUTPUT

echo "exit_code=$SCAN_EXIT_CODE" >> $GITHUB_OUTPUT

exit $SCAN_EXIT_CODE
