# .bashrc

#  Script: bash_prompt.sh
# Purpose: Shell configuration main entry point file
# Created: Aug 26, 2008
#  Author: <B>H</B>ugo <B>S</B>aporetti <B>J</B>unior
#  Mailto: yorevs@hotmail.com
#    Site: https://github.com/yorevs/homesetup

# Source global definitions

if [ -f "$HOME_SETUP/VERSION" ]
then
    export DOTFILES_VERSION=$(cat "$HOME_SETUP/VERSION")
    v=$(curl -s -m 3 https://raw.githubusercontent.com/yorevs/homesetup/master/VERSION)
    test -n "$v" -a -n "$DOTFILES_VERSION" -a "$DOTFILES_VERSION" != "$v" && echo -e "${YELLOW}You have an outdated version of HomeSetup:\n  => Repository: ${v} , Yours: ${DOTFILES_VERSION}.${NC}"
fi

if [ -f /etc/bashrc ]
then
    source /etc/bashrc
fi

if [ -n "$PS1" -a -f ~/.bash_profile ]
then
    source ~/.bash_profile;
fi
