#!/bin/bash

# Filter out any empty args
args=$(for var in "$@"; do echo "$var";done | grep =.)
RULE_BREACHES=`docker run --rm -v .:/tmp/scan -v $rule_loc:/tmp/rules bearer/bearer:canary-amd64 scan /tmp/scan --host=my.staging.bearer.sh --exit-code=0 --quiet ${args//$'\n'/ }`
    
SCAN_EXIT_CODE=$?

echo "::debug::$RULE_BREACHES"

EOF=$(dd if=/dev/urandom bs=15 count=1 status=none | base64)

echo "rule_breaches<<$EOF" >> $GITHUB_OUTPUT
echo "$RULE_BREACHES" >> $GITHUB_OUTPUT
echo "$EOF" >> $GITHUB_OUTPUT

echo "exit_code=$SCAN_EXIT_CODE" >> $GITHUB_OUTPUT

exit $SCAN_EXIT_CODE
