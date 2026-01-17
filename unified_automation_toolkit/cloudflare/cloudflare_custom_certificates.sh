#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Mohammed Abdullah
#  Date: 2020-09-02 18:56:31 +0100 (Wed, 02 Sep 2020)
#
#  https://github.com/mohammed-abdullah/unified_automation_toolkit
#
#  License: see accompanying Mohammed Abdullah LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/mohammed--abdullah/
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090,SC1091
. "$srcdir/lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
For a given Cloudflare zone, list the custom certificates

Output format:

<id>    <expiry_date>    <status>    <hosts>
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="<zone_id>"

help_usage "$@"

min_args 1 "$@"

zone_id="$1"

"$srcdir/cloudflare_api.sh" "/zones/$zone_id/custom_certificates" | jq -r '.result[] | [ .expires_on, .status, (.hosts | join(",")) ] | @tsv'
