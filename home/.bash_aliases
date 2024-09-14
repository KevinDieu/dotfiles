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

safe-alias k "kubectl"
safe-alias scb "clip.exe"
safe-alias bat batcat
safe-alias fd fdfind
safe-alias rms trash-put
safe-alias ap ansible-playbook
safe-alias a ansible
safe-alias ad ansible-doc
safe-alias tf terraform

