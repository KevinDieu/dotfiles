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

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias checkd="checkov -d . --quiet --skip-check CKV_TF_1 --skip-path examples"

alias k='kubectl'
alias scb='clip.exe'
alias rms='trash-put'
alias ap='ansible-playbook'
alias a='ansible'
alias ad='ansible-doc'
alias tf='terraform'
safe-alias fd fdfind
safe-alias bat 'batcat'

# Alis cht to local version if available.
# Otherwise create alias function to curl cht.sh
if [[ -n $(command -v "cht.sh") ]]; then
    alias cht='cht.sh'
else
    cht(){
        curl "cht.sh/$1"
    }
fi
