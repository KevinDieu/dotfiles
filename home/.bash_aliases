#!/bin/bash

#############
# Aliases
#############

safe-alias (){
    # Check if exactly two arguments are provided
    if [[ $# -ne 2 ]]; then
        echo "Error: You must provide exactly two arguments."
        echo "Usage: safe-alias <alias_name> <command>"
        return 1
    fi

    # Check if any of the arguments is --help
    if [[ "$1" == "--help" || "$2" == "--help" ]]; then
        echo "Usage: safe-alias <alias_name> <command>"
        echo "Safely creates an alias if the command exists."
        echo "Example: safe-alias ap ansible-playbook"
        return
    fi

    if [[ -n $(command -v "$2") ]]; then
        alias "$1"="$2"
    fi
}

alias ll='ls -lahF'
alias la='ls -Ah'
alias l='ls -CFh'
alias checkd="checkov -d . --quiet --skip-check CKV_TF_1 --skip-path examples"

alias k='kubectl'
alias scb='clip.exe'
alias rms='trash-put'
alias ap='ansible-playbook'
alias al='ansible-lint'
alias a='ansible'
alias ad='ansible-doc'
alias tf='terraform'
alias pssh='parallel-ssh'
alias fd='fdfind'
alias bat='batcat'

alias memtop='top -o %MEM'
alias ag='ansible-galaxy'
alias gp='git pull'
alias lxl='lxc list -f compact'
alias pr='pr -w $COLUMNS'
alias pssh='parallel-ssh'
# Always color ip output
alias ip='ip -c'


# Alis cht to local version if available.
# Otherwise create alias function to curl cht.sh
if [[ -n $(command -v "cht.sh") ]]; then
    alias cht='cht.sh'
else
    cht(){
        curl -s "cht.sh/$1"
    }
fi



#############
# FUNCTIONS
#############
