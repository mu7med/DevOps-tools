#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Mohammed Abdullah
#  Date: 2020-03-01 21:01:50 +0000 (Sun, 01 Mar 2020)
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

echo "downloading Oh-my-Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
