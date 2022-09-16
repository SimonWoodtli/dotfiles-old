
################################ EXPORTS ###############################

for dir in desktop documents downloads mnt music pictures private public \
  repos templates videos workspaces; do
  upper=${dir^^}
  cap=${dir^}
  if [ -d "$HOME/$cap" ]; then
    eval "export $upper='$HOME/$cap'"
  elif [ -d "$HOME/$dir" ]; then
    eval "export $upper='$HOME/$dir'"
  fi
done

export USER="${USER:-$(whoami)}"
export BROWSER=/usr/sbin/librewolf
export VIRTUALMACHINES="$HOME/VirtualMachines"
export TERM=xterm-256color
export HELP_BROWSER=lynx
export ZETDIR="$GHREPOS/zet"
export ZETTELCASTS="$VIDEOS/ZettelCasts"
_have git && export GITUSER="$(git config --global user.name)"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export SCRIPTS_PRIV="$PRIVATE/scripts"
## used for `pdf` script
export PDFDIR=$GHREPOS/importantBooks
## used for `zet-old` script
#export KN=$HOME/Repos/github.com/$GITUSER
## IBUS config for chinese pinyin input
export GTK_IM_MODULE=IBUS
export XMODIFIERS=@im=IBUS
export QT_IM_MODULE=IBUS
export ANSIBLE_INVENTORY="$HOME/.config/ansible/ansible_hosts"
export DOCKER_HOST=unix:///run/user/$(id -u)/docker.sock

_have deno && export DENO_INSTALL_ROOT="$HOME/.deno/bin"
_have sdk && export SDKMAN_DIR="$HOME/.sdkman"
_have fzf && export FZF_DEFAULT_OPTS="--height 30% --layout=reverse --border --info=inline"
