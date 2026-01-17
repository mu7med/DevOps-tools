#!/bin/sh
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Mohammed Abdullah
#  Date: 2015-05-25 01:38:24 +0100 (Mon, 25 May 2015)
#
#  https://github.com/mohammed-abdullah/unified_automation_toolkit
#
#  License: see accompanying Mohammed Abdullah LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  https://www.linkedin.com/in/mohammed--abdullah/
#

set -eu
[ -n "${DEBUG:-}" ] && set -x
#srcdir_bash_tools_utils_bourne="$(cd "$(dirname "$0")" && pwd)"

if [ "${bash_tools_utils_bourne_imported:-0}" = 1 ]; then
    return 0
fi
bash_tools_utils_bourne_imported=1

am_root(){
    # shellcheck disable=SC2039,SC3028
    [ "${EUID:-${UID:-$(id -u)}}" -eq 0 ]
}

if am_root; then
    sudo=""
else
    sudo=sudo
fi
export sudo

export support_msg="Please raise a GitHub Issue at https://github.com/mohammed-abdullah/unified_automation_toolkit/issues"
