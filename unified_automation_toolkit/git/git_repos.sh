#!/usr/bin/env bash
# shellcheck disable=SC2230
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Mohammed Abdullah
#  Date: 2020-04-04 18:54:17 +0100 (Sat, 04 Apr 2020)
#
#  https://github.com/mohammed-abdullah/unified_automation_toolkit
#
#  License: see accompanying Mohammed Abdullah LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/mohammed--abdullah/
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

repofile="$srcdir/../setup/repos.txt"

if [ -f "$repofile" ]; then
    echo "processing repos from local file: $repofile" >&2
    cat "$repofile"
else
    echo "fetching repos from GitHub repos.txt:" >&2
    curl -sSL https://raw.githubusercontent.com/mohammed-abdullah/bash-tools/master/setup/repos.txt
fi |
sed 's/#.*//; s/.*://; /^[[:space:]]*$/d'
