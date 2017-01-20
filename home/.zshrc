## history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
#setopt BANG_HIST               # Treat the '!' character specially during expansion.
#setopt EXTENDED_HISTORY        # Write the history file in the ":start:elapsed;command" format.
#setopt INC_APPEND_HISTORY      # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY           # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS        # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS    # Delete old recorded entry if new entry is a duplicate.
#setopt HIST_FIND_NO_DUPS       # Do not display a line previously found.
setopt HIST_IGNORE_SPACE       # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS       # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks before recording entry.
#setopt HIST_VERIFY             # Don't execute immediately upon history expansion.
#setopt HIST_BEEP               # Beep when accessing nonexistent history.

## alias declaration
alias v='vim'
alias p='sudo pacman'
alias c='clear'
alias q='exit'
alias gp='git push origin master'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias -g L='| less'
alias -g N='&> /dev/null'
alias -g G='| grep -i'
alias grep='grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'
alias ls='ls --color=tty'

## plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

## fix home/end buttons
bindkey "^[[4~" end-of-line
bindkey "^[[8~" end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[7~" beginning-of-line
bindkey "^[[3~" delete-char

## damn kb speed is always resetting
if [ $DISPLAY ]; then xset r rate 250 45; fi

## completions
# general auto complete
autoload -Uz compinit
compinit
# auto complete with arrow keys, press tab twice
zstyle ':completion:*' menu select
# this is from intro
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 3 numeric
# complete kill with ps
zstyle ':completion:*:*:*:*:processes' command "ps -o pid,user,comm -x -w -w"
# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $HOME/.zshcache
# complete aliases
setopt COMPLETE_ALIASES

# history search
autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "$key[Up]" ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

## pressing ESC two times toggles 'sudo' in front of cmd
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
# Defined shortcut keys: [Esc] [Esc]
bindkey "\e\e" sudo-command-line


## other stuff
# exports
export EDITOR='vim'
# ls colors
autoload -U colors && colors
(( $+commands[dircolors] )) && eval "$(dircolors -b)"
 
## functions for prompt
git_branch () {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/';
    return 0;
}
git_dirty() {
    local STATUS=''
    STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
    if [[ -n $STATUS ]]; then
        echo " *"
    fi
}
git_prompt() {
    if git status >/dev/null 2>&1; then
        echo " %F{cyan}GIT[$(git_branch)%f%F{red}$(git_dirty)%f%F{cyan}]%f"
    fi
}

function get_pwd1() {
    echo "${PWD/$HOME/~}"
}

function prompt_char {
    if [ $UID -eq 0 ]; then echo " #"; else echo ' '$; fi
}

function sh_level {
    if [ $SHLVL -gt 2 ]; then echo "⑂ "; fi
}

function exit_code {
    local return_code="%(?..%F{red}%? %f)"
    echo $return_code
}


## prompt

setopt prompt_subst

if [ $SSH_CONNECTION ]; then SSH="%n@%m"; else SSH=""; fi

PROMPT='${SSH}$(git_prompt)$(prompt_char) '
RPROMPT='$(sh_level)$(exit_code)%~'
