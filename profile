#
# ~/.bash_profile
#

if [[ -f ~/.bashrc ]]; then . ~/.bashrc; fi

## auto-launch into gui -> no display manager
#[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx --vt1
