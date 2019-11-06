#!/usr/bin/env bash

#  Script: hhs-paths.sh
# Created: Oct 5, 2019
#  Author: <B>H</B>ugo <B>S</B>aporetti <B>J</B>unior
#  Mailto: yorevs@hotmail.com
#    Site: https://github.com/yorevs/homesetup
# License: Please refer to <http://unlicense.org/>
# !NOTICE: Do not change this file. To customize your functions edit the file ~/.functions

# @function: Print each PATH entry on a separate line.
# shellcheck disable=SC2155
function __hhs_paths() {

    PATHS_FILE=${PATHS_FILE:-$HOME/.path}

    local pad
    local pad_len
    local path_dir
    local custom
    local private

    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "Usage: ${FUNCNAME[0]} [options] <args>"
        echo ''
        echo 'Options: '
        echo '                     : Lists all path entries.'
        echo '           -a <path> : Add to the current <path> .'
        echo '           -r <path> : Remove from the current <path> .'
        echo '           -e        : Edit current PATHS_FILE .'
        return 1
    else
        if [ -z "$1" ]; then
            [ -f "$PATHS_FILE" ] || touch "$PATHS_FILE"
            pad=$(printf '%0.1s' "."{1..70})
            pad_len=70
            columns=66
            echo ' '
            echo "${YELLOW}Listing all PATH entries:"
            echo ' '
            (
                IFS=$'\n'
                for path in $(echo -e "${PATH//:/\\n}"); do
                    path="${path:0:$columns}"
                    custom="$(grep ^"$path"$ "$PATHS_FILE")" # Custom paths
                    private="$(grep ^"$path"$ /private/etc/paths)" # Private system paths
                    path_dir="$(grep ^"$path"$ /etc/paths.d/*)" # General system path dir
                    printf "%s" "${HIGHLIGHT_COLOR}${path}"
                    printf '%*.*s' 0 $((pad_len - ${#path})) "$pad"
                    [ "${#path}" -ge "$columns" ] && echo -n "${NC}" || echo -n "${NC}"
                    if [ -d "$path" ]; then
                        echo -en "${GREEN} ${CHECK_ICN} => "
                    else
                        echo -en "${RED} ${CROSS_ICN} => "
                    fi
                    [ -n "$custom" ] && printf '%s\n' "custom"
                    [ -n "$path_dir" ] && printf '%s\n' "paths.d"
                    [ -n "$private" ] && printf '%s\n' "private"
                    [ -z "$custom" ] && [ -z "$path_dir" ] && [ -z "$private" ] && printf '%s\n' "exported"
                done
                IFS="$RESET_IFS"
            )
            echo -e "${NC}"
        elif [ "-e" = "$1" ]; then
            vi "$PATHS_FILE"
            return 0
        elif [ "-a" = "$1" ] && [ -n "$2" ]; then
            ised -e "s#(^$2$)*##g" -e '/^\s*$/d' "$PATHS_FILE"
            [ -d "$2" ] && echo "$2" >> "$PATHS_FILE"
            export PATH="$2:$PATH"
        elif [ "-r" = "$1" ] && [ -n "$2" ]; then
            export PATH=${PATH//$2:/}
            ised -e "s#(^$2$)*##g" -e '/^\s*$/d' "$PATHS_FILE"
        fi
    fi
    # Remove all $PATH duplicated entries
    export PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: '!arr[$0]++')

    return 0
}