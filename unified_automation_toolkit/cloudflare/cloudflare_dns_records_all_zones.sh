#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Mohammed Abdullah
#  Date: 2020-09-02 18:17:26 +0100 (Wed, 02 Sep 2020)
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
Lists all DNS records in Cloudflare across all zones

https://api.cloudflare.com/#dns-records-for-a-zone-list-dns-records

Output format:

<dns_record>    <type>    <ttl>
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args=""

help_usage "$@"

"$srcdir/cloudflare_foreach_zone.sh" "$srcdir/cloudflare_dns_records.sh {zone_id}"
