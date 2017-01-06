# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_HIDE_HOST=false
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time)

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Used for some OHZsh themes to determine if user@host should be printed
export DEFAULT_USER=bhilburn

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Highlight all available matches
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(zsh-syntax-highlighting gitfast git-extras svn history-substring-search colored-man colorize copyfile copydir cp dircycle command-not-found)

# Stop screwing up my tmux names
DISABLE_AUTO_TITLE=true

### KEY BINDINGS ############################################################
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Have to do this again for tmux
#bindkey '^[[B' history-substring-search-down
#bindkey '^[[A' history-substring-search-up

## Vim key bindings
bindkey '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey -M viins "\e." insert-last-word
bindkey -M vicmd "\e." insert-last-word

#!/bin/sh
cp_p()
{
   strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
        count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# push current command to stack, run a different command, pop from stack
bindkey '^Q' push-input

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/home/bhilburn/usr/bin:/home/bhilburn/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/bhilburn/bin

export LD_LIBRARY_PATH=~/usr/lib64:~/usr/lib:${LD_LIBRARY_PATH}

# For Xilinx Build Tools
export XILINX=/opt/Xilinx/14.7/ISE_DS
export PATH=${PATH}:${XILINX}/ISE/bin/lin64:${XILINX}/EDK/gnu/microblaze/lin64/bin
export _JAVA_AWT_WM_NONREPARENTING=1
export XIL_IMPACT_USE_LIBUSB=1
export XILINXD_LICENSE_FILE=2100@us-aus-pcbflex.amer.corp.natinst.com

export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"

export PYTHONPATH=/home/bhilburn/usr/lib64/python2.7/site-packages:/usr/lib/python2.7/site-packages:/usr/local/lib/python2.7/site-packages:/usr/lib64/python2.7/site-packages:/usr/local/lib64/python2.7/site-packages

alias ls="ls --color=always -FG"
alias gr="grep --exclude-dir=build --exclude-dir=swig --exclude-dir=.git --exclude=tags --exclude=TAGS --exclude-dir=site --exclude-dir=.deps -rniI "
alias h="history | grep "
alias tree="git log --graph --decorate --pretty=oneline --abbrev-commit"

# Use ccache for all things
export PATH="/usr/lib64/ccache:$PATH"

bindkey "\e[3~" delete-char
