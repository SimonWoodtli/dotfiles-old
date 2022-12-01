
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
export BROWSER=/usr/bin/brave-browser
export WWW_HOME=https://lite.duckduckgo.com/lite # ~ for w3m
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
export PDFDIR="$HOME/Documents/books/importantBooks"
## used for `zet-old` script
#export KN=$HOME/Repos/github.com/$GITUSER
## IBUS config for chinese pinyin input
export GTK_IM_MODULE=IBUS
export XMODIFIERS=@im=IBUS
export QT_IM_MODULE=IBUS
export ANSIBLE_INVENTORY="$HOME/.config/ansible/ansible_hosts"
export DOCKER_HOST=unix:///run/user/$(id -u)/docker.sock

_have bat && export BAT_PAGER="less -R"
_have deno && export DENO_INSTALL_ROOT="$HOME/.deno/bin"
_have sdk && export SDKMAN_DIR="$HOME/.sdkman"
################################## fzf #################################
#keybindingds: f2,f3,f4,.....
##TODO add f5 key binding to open with xdg-open
_have fzf && export FZF_DEFAULT_OPTS="--no-mouse --height 80% --layout=reverse --multi --info=inline --preview='$HOME/.vimplugins/fzf.vim/bin/preview.sh {}' --preview-window='right:60%:wrap' --bind='f2:toggle-preview,f3:execute(bat --style=numbers {} || less -f {}),f4:execute($EDITOR {}),alt-w:toggle-preview-wrap,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+} | pbcopy),ctrl-x:execute(rm -i {+})+abort,ctrl-l:clear-query'"
_have fd && _have fzf && export FZF_DEFAULT_COMMAND='fd --type f --type l --hidden --follow --exclude .git'
## fzf comes with some keybindings, I don't wanna introduce bad muscle memory.
## CTRL commands are reserved for signals and that's that. I only use CTRL-R for
## history search since that is aready a default on many terminals. And
## some ctrl commands within a fzf window (not sure if I like that)
