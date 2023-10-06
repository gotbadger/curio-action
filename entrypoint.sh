#!/bin/bash

wget https://github.com/Bearer/bearer/releases/download/untagged-57bcb7d3d621040187fe/bearer_1.26.0_linux_amd64.tar.gz
tar -zxvf *.tar.gz bearer
mv bearer $RUNNER_TEMP/

# Filter out any empty args
args=$(for var in "$@"; do echo "$var";done | grep =.)

RULE_BREACHES=`$RUNNER_TEMP/bearer scan --host=my.staging.bearer.sh --exit-code=0 --quiet ${args//$'\n'/ } .`
SCAN_EXIT_CODE=$?

echo "::debug::$RULE_BREACHES"

EOF=$(dd if=/dev/urandom bs=15 count=1 status=none | base64)

echo "rule_breaches<<$EOF" >> $GITHUB_OUTPUT
echo "$RULE_BREACHES" >> $GITHUB_OUTPUT
echo "$EOF" >> $GITHUB_OUTPUT

echo "exit_code=$SCAN_EXIT_CODE" >> $GITHUB_OUTPUT

exit $SCAN_EXIT_CODE
