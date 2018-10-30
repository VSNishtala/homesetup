#!/usr/bin/env bash

#  Script: bash_env.sh
# Purpose: Configure shell environment variables
# Created: Aug 26, 2008
#  Author: <B>H</B>ugo <B>S</B>aporetti <B>J</B>unior
#  Mailto: yorevs@hotmail.com
#    Site: https://github.com/yorevs/homesetup
# !NOTICE: Do not change this file. To customize your aliases edit the file ~/.env

# Home Sweet Homes
command -v java >/dev/null && export JAVA_HOME="/Library/Java/JavaVirtualMachines/Current/Contents/Home"
command -v java >/dev/null && export JDK_HOME="$JAVA_HOME"
command -v python >/dev/null && export PYTHON_HOME="/System/Library/Frameworks/Python.framework/Versions/Current"
command -v qmake >/dev/null && export QT_HOME="$HOME/Applications/QT/Current/clang_64"

# shellcheck disable=SC2155
command -v xcode-select >/dev/null && export XCODE_HOME="$(xcode-select -p)"
command -v xcode-select >/dev/null && export MACOS_SDK="$XCODE_HOME/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"

# Other environment variables
test -d "$HOME/Dropbox" && export DROPBOX="$HOME/Dropbox"
export HOME_SETUP="$HOME/HomeSetup"
export HHS_DIR="$HOME/.hhs"
command -v git >/dev/null && export GIT_REPOS="$HOME/GIT-Repository"
command -v svn >/dev/null && export SVN_REPOS="$HOME/SVN-Repository"
export WORKSPACE="$HOME/Workspace"
export DESKTOP="$HOME/Desktop"
export DOWNLOADS="$HOME/Downloads"
export TEMP="${TEMP:-$TMPDIR}"
export TRASH="${TRASH:-$HOME/.Trash}"

# shellcheck disable=SC2155
export DOTFILES_VERSION=$(grep . "$HOME_SETUP/.VERSION")

# Setting history length ( HISTSIZE and HISTFILESIZE ) in bash
export HISTSIZE=${HISTSIZE:-1000}
export HISTFILESIZE=${HISTFILESIZE:-2000}

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups:ignorespace:ignoreboth:erasedups

# Development tools. To override it please export the same variable at ~/.env
export DEFAULT_DEV_TOOLS=(
    "bash" "brew" "tree" "vim" "pcregrep" "shfmt" "shellcheck"
    "node" "java" "python" "ruby" "gcc" "make" "qmake"
    "doxygen" "ant" "mvn" "gradle" "git" "svn" "cvs"
    "nvm" "npm" "jenv" "eslint" "gpg" "base64" "md5" "shasum"
)