#!/usr/bin/env bash

# when a command fails, bash exits instead of continuing with the rest of the script
set -o errexit
# make the script fail, when accessing an unset variable
set -o nounset
# pipeline command is treated as failed, even if one command in the pipeline fails
set -o pipefail
# enable debug mode, by running your script as TRACE=1
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

: "${GITGUARDIAN_API_KEY?'Expected env var GITGUARDIAN_API_KEY not set'}"
: "${SLACK_WEBHOOK_URL?'Expected env var SLACK_WEBHOOK_URL not set'}"
: "${SNYK_TOKEN?'Expected env var SNYK_TOKEN not set'}"

REPOSITORY="koenighotze/$(basename `git rev-parse --show-toplevel`)"

gh secret set GITGUARDIAN_API_KEY -R "${REPOSITORY}" -b "${GITGUARDIAN_API_KEY}"
gh secret set SLACK_WEBHOOK_URL -R "${REPOSITORY}" -b "${SLACK_WEBHOOK_URL}"
gh secret set SNYK_TOKEN -R "${REPOSITORY}" -b "${SNYK_TOKEN}"
