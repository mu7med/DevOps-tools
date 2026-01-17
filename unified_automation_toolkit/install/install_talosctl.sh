#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Mohammed Abdullah
#  Date: 2023-03-06 13:21:08 +0000 (Mon, 06 Mar 2023)
#
#  https://github.com/mohammed-abdullah/unified_automation_toolkit
#
#  License: see accompanying Mohammed Abdullah LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/mohammed--abdullah/
#

# https://www.talos.dev/v1.3/introduction/quickstart/

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090,SC1091
. "$srcdir/../lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Installs Talos 'talosctl' client binary
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args=""

help_usage "$@"

curl -sSL https://talos.dev/install | sh
