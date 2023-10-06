#!/bin/bash

# Filter out any empty args
args=$(for var in "$@"; do echo "$var";done | grep =.)

wget https://github.com/gotbadger/curio-action/raw/main/bin/bearer_1.26.0_linux_amd64.tar.gz
tar -zxvf *.tar.gz bearer
mv bearer $RUNNER_TEMP/

echo "============================================================="
echo "SHA=$SHA"
echo "ORIGIN_URL=$ORIGIN_URL"
echo "CURRENT_BRANCH=$CURRENT_BRANCH"
echo "DIFF_BASE_BRANCH=$DIFF_BASE_BRANCH"
echo "DEFAULT_BRANCH=$DEFAULT_BRANCH"
echo "GITHUB_REPOSITORY=$GITHUB_REPOSITORY"
echo "============================================================="
$RUNNER_TEMP/bearer version
echo "============================================================="


RULE_BREACHES=`$RUNNER_TEMP/bearer scan --host=my.staging.bearer.sh --debug ${args//$'\n'/ } .`
SCAN_EXIT_CODE=$?

echo "::debug::$RULE_BREACHES"

EOF=$(dd if=/dev/urandom bs=15 count=1 status=none | base64)

echo "rule_breaches<<$EOF" >> $GITHUB_OUTPUT
echo "$RULE_BREACHES" >> $GITHUB_OUTPUT
echo "$EOF" >> $GITHUB_OUTPUT

echo "exit_code=$SCAN_EXIT_CODE" >> $GITHUB_OUTPUT

exit $SCAN_EXIT_CODE
