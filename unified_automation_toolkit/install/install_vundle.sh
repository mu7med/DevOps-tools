#!/usr/bin/env bash
# shellcheck disable=SC2230
#
#  Author: Mohammed Abdullah
#  Date: 2020-01-03 12:14:36 +0000 (Fri, 03 Jan 2020)
#
#  https://github.com/mohammed-abdullah/unified_automation_toolkit
#
#  License: see accompanying LICENSE file
#
#  https://www.linkedin.com/in/mohammed--abdullah/
#

# Installs Vim plugin manager Vundle to $HOME/.vim/bundle/Vundle.vim

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

if ! type -P vim &>/dev/null; then
    echo "Vim not installed, aborting..."
    exit 1
fi

target=~/.vim/bundle/Vundle.vim

mkdir -pv "${target%/*}"

if ! [ -e "$target" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git "$target"
fi

date "+%F %T  Installing Vim Vundle plugins..."
# this tends to mess up the terminal and requires a reset afterwards
vim --not-a-term +PluginInstall +qall >/dev/null
date "+%F %T  Finished installing Vim Vundle plugins"
