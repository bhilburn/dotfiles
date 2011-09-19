#!/bin/bash

# Set the default session to openbox
session_default=gnome

# Allow specifying a session with startx
session=$2
test -z "$session" && session=$session_default

# Start the URxvt daemon
urxvtd -q -o -f &

# Turn numlock on
[[ -x "/usr/bin/numlockx" ]] && numlockx &

# Restore the previous background
#eval `cat ~/.fehbg` &
nitrogen --restore &

# Make sure we are in Dvorak
setxkbmap dvorak &

case $session in
    "gnome")
        alunn &
        fusion-icon &
        exec gnome-session;;

    "stumpwm")
        xmodmap $HOME/.Xmodmap &
        xscreensaver -no-splash &
        exec /usr/bin/stumpwm;;

    "xmonad")
        cairo-compmgr &
        xsetroot -cursor_name left_ptr &
        xmodmap $HOME/.Xmodmap &
        xscreensaver -no-splash &
        xmonad;;

    "wmii")
        zsh $HOME/bin/dzconky &
        exec wmii;;

    *)

esac
