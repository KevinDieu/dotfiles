#############################
# Environment Configuration
#############################

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# LESS settings for improved scrolling experience
export LESS='-R --wheel-lines=3'

# Add custom bin directories to PATH (portable expansion)
export PATH="$HOME/bin:$HOME/scripts:${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Preferred editor for both local and remote sessions
export EDITOR='vim'

############################
# Oh-My-Zsh Configuration
############################

# Path to your Oh-My-Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration
ZSH_THEME="gallois"

# Auto-update configuration
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' frequency 13  # Optional: specify update frequency in days

# Disable auto-setting terminal title (optional)
DISABLE_AUTO_TITLE="true"

# Enable command auto-correction
ENABLE_CORRECTION="true"

# History configuration
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

# Append to history immediately instead of on shell exit
setopt INC_APPEND_HISTORY

# Share history between terminals
setopt HIST_EXPIRE_DUPS_FIRST

# Plugins configuration
plugins=(
    z
    sudo
    zsh-autosuggestions
)

# Source Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

########################
# Custom Configuration
########################

# Homeshick Configuration
if [[ -f "$HOME/.homesick/repos/homeshick/homeshick.sh" ]]; then
    source "$HOME/.homesick/repos/homeshick/homeshick.sh"
    fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
fi

# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Disable autocorrect for specific commands
alias krew='nocorrect krew'

# Bind F8 to history search
bindkey '\e[19~' history-beginning-search-backward

# Load Homebrew environment if available
if command -v brew &> /dev/null; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

####################################
# Shell Enhancements & Completions
####################################

# Initialize completion system
autoload -U +X compinit && compinit

# Enable kubectl autocompletion
source <(kubectl completion zsh)

######################
# Tmux Configuration
######################

# Attach or create a tmux session if tmux is installed
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
fi
