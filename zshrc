# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="hokietux"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git svn)

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

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/bhilburn/bin:/home/bhilburn/applications/CodeSourcery/bin

export XILINX=/opt/Xilinx/14.4/ISE_DS
export PATH=${PATH}:${XILINX}/ISE/bin/lin64:${XILINX}/EDK/gnu/microblaze/lin64/bin
export _JAVA_AWT_WM_NONREPARENTING = 1

export CCACHE_PATH="/usr/bin"

export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"

export PYTHONPATH=/usr/lib/python2.7/site-packages:/usr/local/lib/python2.7/site-packages:/usr/lib64/python2.7/site-packages:/usr/local/lib64/python2.7/site-packages:/home/bhilburn/code/ettus/autotest.git/characterization:/home/bhilburn/code/ettus/autotest.git/

export DJANGO_SETTINGS_MODULE=characterize.settings

alias ls="ls -FG --color=always"
alias gr="grep -rniI "
alias h="history | grep "
alias tree="git log --graph --decorate --pretty=oneline --abbrev-commit"

eval `keychain --eval --agents ssh id_rsa`
