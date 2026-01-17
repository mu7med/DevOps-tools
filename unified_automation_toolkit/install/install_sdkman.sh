#!/usr/bin/env bash
#
#  Author: Mohammed Abdullah
#  Date: 2019-10-04 16:36:18 +0100 (Fri, 04 Oct 2019)
#        (circa 2016 originally)
#
#  https://github.com/mohammed-abdullah/unified_automation_toolkit
#
#  License: see accompanying LICENSE file
#
#  https://www.linkedin.com/in/mohammed--abdullah/
#

# Installs SDKMan

# https://sdkman.io/install

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

curl -sS "https://get.sdkman.io" | bash
