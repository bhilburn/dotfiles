# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1
#POWERLEVEL9K_ALWAYS_SHOW_USER=true
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time history time)
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

ZSH_THEME="powerlevel9k/powerlevel9k"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-eighties.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Used for some OHZsh themes to determine if user@host should be printed
export DEFAULT_USER=bhilburn

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Highlight all available matches
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(gitfast git-extras svn colored-man dircycle zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-history-substring-search)
autoload -U compinit && compinit

# Stop screwing up my tmux names
DISABLE_AUTO_TITLE=true

### KEY BINDINGS ############################################################
zmodload zsh/terminfo
zle -N history-substring-search-up
zle -N history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Have to do this again for tmux
#bindkey '^[[B' history-substring-search-down
#bindkey '^[[A' history-substring-search-up

zle -N autosuggest-accept
bindkey '^@' autosuggest-accept
zle -N autosuggest-execute
bindkey '^M' autosuggest-execute

# push current command to stack, run a different command, pop from stack
fancy-ctrl-z () {
    emulate -LR zsh
    if [[ $#BUFFER -eq 0 ]]; then
        bg
        zle redisplay
    else
        zle push-input
    fi
}
zle -N fancy-ctrl-z
bindkey '^q' fancy-ctrl-z

# Load Oh-My-ZSH
source $ZSH/oh-my-zsh.sh

export LD_LIBRARY_PATH=~/usr/lib64:~/usr/lib:${LD_LIBRARY_PATH}

# Use ccache for all things
export PATH="/usr/lib64/ccache:$PATH"

export PYTHONPATH=$PYTHONPATH:/home/bhilburn/usr/lib64/python2.7/site-packages:/usr/lib/python2.7/site-packages:/usr/local/lib/python2.7/site-packages:/usr/lib64/python2.7/site-packages:/usr/local/lib64/python2.7/site-packages

alias ls="ls --color=always -FG"
alias gr="grep --exclude-dir=build --exclude-dir=swig --exclude-dir=.git --exclude=tags --exclude=TAGS --exclude-dir=site --exclude-dir=.deps -rniI "
alias h="history | grep "
alias tree="git log --graph --decorate --pretty=oneline --abbrev-commit"
