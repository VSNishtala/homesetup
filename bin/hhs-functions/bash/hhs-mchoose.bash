#!/usr/bin/env bash

#  Script: hhs-mchoose.bash
# Created: Jan 16, 2020
#  Author: <B>H</B>ugo <B>S</B>aporetti <B>J</B>unior
#  Mailto: yorevs@hotmail.com
#    Site: https://github.com/yorevs/homesetup
# License: Please refer to <http://unlicense.org/>
# !NOTICE: Do not change this file. To customize your functions edit the file ~/.functions

# @function: Select an option from a list using a navigable menu.
# @param $1 [Req] : The response file.
# @param $2 [Req] : The array of options.
function __hhs_mchoose() {
  
  if [[ $# -eq 0 ]] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "Usage: ${FUNCNAME[0]} <output_file> <options...>"
    echo ''
    echo '  Notes: '
    echo '    - A temporary file is suggested to used with this command: #> mktemp'
    echo '    - The outfile must not exist or it be an empty file'
    return 1
  fi

  if [ -d "$1" ] || [ -s "$1" ]; then
    echo -e "${RED}\"$1\" is a directory or an existing non-empty file !${NC}"
    return 1
  fi

  HHS_MENU_MAXROWS=${HHS_MENU_MAXROWS:=15}

  local all_options=() sel_options=() outfile="$1" cur_index=0 show_from=0 re_render=1 
  local index_len len show_to diff_index typed_index columns option_line
  
  show_to="$((HHS_MENU_MAXROWS - 1))"
  diff_index="$((show_to - show_from))"
  shift
  # shellcheck disable=SC2206
  all_options=(${@})
  len=${#all_options[*]}

  # When only one option is provided, select the typed_index 0 and return
  [ "$len" -eq 1 ] && echo "0" > "$outfile" && return 0
  save-cursor-pos
  disable-line-wrap

  while :; do
    columns="$(($(tput cols) - 7))"

    # Menu Renderization {
    if [ -n "$re_render" ]; then
      hide-cursor
      # Erase current line and restore the cursor to the home position
      restore-cursor-pos
      echo -e "${NC}"
      for idx in $(seq "$show_from" "$show_to"); do
        local selector=' '
        [[ $idx -ge $len ]] && break # When the number of items is lower than the maxrows, skip the other lines
        option_line="${all_options[idx]:0:$columns}"
        # Erase current line before repaint
        echo -ne "\033[2K\r"
        [[ $idx -eq $cur_index ]] && echo -en "${HHS_HIGHLIGHT_COLOR}" && selector='x' # Highlight the selected line
        printf " %.${#len}d  %0.4s %s" "$((idx + 1))" "[$selector]" "$option_line"       # Print the option line
        # Check if the text fits the screen and print it, otherwise print '...'
        [[ ${#option_line} -ge $columns ]] && echo -e "\033[4D\033[K..."
        echo -e "${NC}"
      done
      echo ''
      echo -n "${YELLOW}[Enter] Select [↑↓] Navigate [X] Mark [Q] Quit [1..${len:0:5}] Goto: "
      re_render=
      show-cursor
    fi
    # } Menu Renderization
    
    # Navigation input {
    read -rs -n 1 KEY_PRESS
    case "$KEY_PRESS" in
      'q' | 'Q') # Quit requested
        enable-line-wrap
        echo -e "\n${NC}"
        return 1
        ;;
      'x' | 'X') # Mark option
        ;;
      [1-9]) # A number was typed
        typed_index="$KEY_PRESS"
        echo -en "$KEY_PRESS" && index_len=1
        while [[ ${#typed_index} -lt ${#len} ]]; do
          read -rs -n 1 NUM_PRESS
          [ -z "$NUM_PRESS" ] && break
          [[ ! "$NUM_PRESS" =~ ^[0-9]*$ ]] && typed_index= && break
          typed_index="${typed_index}${NUM_PRESS}"
          echo -en "$NUM_PRESS" && index_len=$((index_len + 1))
        done
        echo -ne "\033[${index_len}D\033[K"
        if [[ $typed_index -ge 1 ]] && [[ $typed_index -le $len ]]; then
          show_to=$((typed_index - 1))
          [ "$show_to" -le "$diff_index" ] && show_to=$diff_index
          show_from=$((show_to - diff_index))
          cur_index=$((typed_index - 1)) && re_render=1
        fi
        ;;
      $'\033') # Handle escape '\e[nX' codes
        read -rsn2 KEY_PRESS
        case "$KEY_PRESS" in
          [A) # Cursor up
            if [[ $cur_index -eq $show_from ]] && [[ $show_from -gt 0 ]]; then
              show_from=$((show_from - 1))
              show_to=$((show_to - 1))
            elif [[ $cur_index -eq 0 ]]; then
              continue
            fi
            if [[ $((cur_index - 1)) -ge 0 ]]; then
              cur_index=$((cur_index - 1)) && re_render=1
            fi
            ;;
          [B) # Cursor down
            if [[ $cur_index -eq $show_to ]] && [[ $((show_to + 1)) -lt $len ]]; then
              show_from=$((show_from + 1))
              show_to=$((show_to + 1))
            elif [[ $((cur_index + 1)) -ge $len ]]; then
              continue
            fi
            if [[ $((cur_index + 1)) -lt $len ]]; then
              cur_index=$((cur_index + 1)) && re_render=1
            fi
            ;;
        esac
        ;;
      '') # Keep the selected index and exit
        echo '' && break
        ;;
    esac
    # } Navigation input

  done

  show-cursor
  enable-line-wrap
  echo -e "${NC}"
  echo "$cur_index" > "$outfile"

  return 0
}