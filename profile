## if bash is started as an interactive login shell it will read the following files:
## 1.  ~/.bash_profile
## 2.  ~/.profile
## 3.  ~/.bashrc
##  if bash is started as an interactive non-login shell:
## 1. ~/.bashrc

## auto-launch into gui -> no display manager
#[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx --vt1

## source bashrc
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

## set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi
## set go PATH if exists
if [ -d "$HOME/.local/go/bin" ]; then
  PATH="$HOME/.local/go/bin:$PATH"
fi
export QT_STYLE_OVERRIDE=kvantum
export EDITOR=vim

if [ -e /home/sero/.nix-profile/etc/profile.d/nix.sh ]; then . /home/sero/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
