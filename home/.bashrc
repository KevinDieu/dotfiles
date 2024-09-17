###########################
# Interactive Shell Check
###########################

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

#################
# Shell Options
#################

# Enable vi mode
set -o vi

# History options
HISTCONTROL=ignoreboth # Don't put duplicates or lines starting with spaces
shopt -s histappend    # Append to history file instead of overwriting

# Default history size (in case not set)
HISTSIZE="${HISTSIZE:-1000000000}"
HISTFILESIZE="${HISTFILESIZE:-2000000000}"

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Check window size after each command and update LINES and COLUMNS
shopt -s checkwinsize

# Enable "**" to match all files in pathname expansion (optional)
#shopt -s globstar

##################
# Lesspipe Setup
##################

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

##################
# Prompt Setup
##################

# Set variable identifying the chroot you work in (if any)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt with color if the terminal supports it
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# Uncomment for colored prompt (if terminal supports it)
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

#####################
# XTerm Title Setup
#####################

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
esac

##################################
# Alias and Command Enhancements
##################################

# Enable color support of ls and other commands
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls aliases for convenience
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alert alias for long running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Custom aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

###################
# Bash Completion
###################

# Enable programmable completion features
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

########################
# Custom Configuration
########################

# Custom aliases
alias c=clear
complete -F __start_kubectl k

# Add Homeshick primary alias
if [[ -f "$HOME/.homesick/repos/homeshick/homeshick.sh" ]]; then
    source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fi

##############
# Tmux Setup
##############

if [[ "$TERM_PROGRAM" != "vscode" ]]; then
    # Attach or create a tmux session if tmux is installed
    if command -v tmux &>/dev/null && [ -z "$TMUX" ]; then
        tmux attach-session -t default || tmux new-session -s default
    fi
fi
