########################################################################
#______  ___   _____ _   _ ______  _____
#| ___ \/ _ \ /  ___| | | || ___ \/  __ \
#| |_/ / /_\ \\ `--.| |_| || |_/ /| /  \/
#| ___ \  _  | `--. \  _  ||    / | |
#| |_/ / | | |/\__/ / | | || |\ \ | \__/\
#\____/\_| |_/\____/\_| |_/\_| \_| \____/
#
########################################################################




############################### DETECTION ##############################

## Detection of interactivity. Shell *must* be
## interactive or *none* of this applies.

case $- in
  *i*) ;;
  *) return
esac

## Detection of major operating systems.

[ -z "$OS" ] && export OS=`uname`
case "$OS" in
  Linux)          export PLATFORM=linux ;;
  *indows*)       export PLATFORM=windows ;;
  FreeBSD|Darwin) export PLATFORM=mac ;;
  *)              export PLATFORM=unknown ;;
esac

########################### Utility Functions ##########################

_have()      { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }
onmac() { [ "$PLATFORM" == mac ] && return 0 || return 1; }
onwin() { [ "$PLATFORM" == windows ]  && return 0 || return 1; }
onlinux() { [ "$PLATFORM" == linux ]  && return 0 || return 1; }
onunknown() { [ "$PLATFORM" == unknown ]  && return 0 || return 1; }

################################ EXPORTS ###############################

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
## used for `pdf` script
export PDFDIR=$GHREPOS/books/work/essentials
## used for `zet-old` script
#export KN=$HOME/Repos/github.com/$GITUSER
## IBUS config for chinese pinyin input
export GTK_IM_MODULE=IBUS
export XMODIFIERS=@im=IBUS
export QT_IM_MODULE=IBUS

_have deno && export DENO_INSTALL_ROOT="$HOME/.deno/bin"
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

############################## Export PATH #############################

# be sure NOT to add ./ cuz it's unsafe
export PATH=\
$SCRIPTS:\
$SCRIPTS_PRIV:\
/usr/lib/go-1.15/bin:\
$HOME/.local/bin:\
$HOME/.local/go/bin:\
$HOME/.cargo/bin:\
$HOME/.node/bin:\
$HOME/.deno/bin:\
/usr/local/opt/coreutils/libexec/gnubin:\
/usr/local/go/bin:\
/usr/local/tinygo/bin:\
/usr/local/bin:\
/usr/local/sbin:\
/usr/games:\
/usr/sbin:\
/usr/bin:\
/snap/bin:\
/sbin:\
/bin

# be sure not to remove ./ or stuff gets weird
export CDPATH=\
./:\
$REPOS/github.com/$GITUSER:\
$REPOS/github.com/$GITUSER/dotfiles:\
$REPOS/github.com/$GITUSER/books:\
$REPOS/github.com/*:\
$REPOS/github.com:\
$REPOS:\
/media/$USER:\
$HOME

############################### SETTINGS ###############################

## globstar: (ls **filename includes subdirectories):
#set -o noclobber            # paranoid? use >| for everything
shopt -s expand_aliases
shopt -s globstar # globbing with ** matches all files and dir/subdirs
shopt -s dotglob # using the * to `mv` etc. includes .files
shopt -s extglob # enable extended pattern matching in path name expansions
shopt -s histappend # append history instead of overwritting
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s histappend # do not overwrite history
shopt -s checkwinsize # checks term size when bash regains control
#shopt -s nullglob # creates bug FIX ME

HISTCONTROL=ignoreboth
#HISTCONTROL=ignoredups # Ignore duplicates in command history
HISTSIZE=5000 # increase default 500 commands to 5000
HISTFILESIZE=10000
#setxkbmap -option ctrl:ctrl_modifier # map capslock to control
bind "set completion-ignore-case on" # TAB completion ignores upper/lower case
export HRULEWIDTH=73

## fetch fancy git prompt, not needed with current prompt => bloat
#_source_if "$DOTFILES/bin/shell/additional/git-prompt.sh"

################################# PAGER ################################

## if statement is better readable and does the same
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
if [[ -x /usr/bin/lesspipe ]]; then
  export LESSOPEN="| /usr/bin/lesspipe %s";
  export LESSCLOSE="/usr/bin/lesspipe %s %s";
fi

############################## CMD PROMPT ##############################

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@
#\033[38;2;110;110;110m

__ps1() {
  local P='$' dir="${PWD##*/}" B countme short long double\
    r='\[\e[31m\]' g='\033[38;2;110;110;110m' h='\[\e[34m\]' \
    u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
    b='\[\e[36m\]' x='\[\e[0m\]'

  [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'

  B=$(git branch --show-current 2>/dev/null)
  [[ $dir = "$B" ]] && B=.
  countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

  [[ $B = master || $B = main ]] && b="$r"
  [[ -n "$B" ]] && B="$g($b$B$g)"

  short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
  long="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n$g╚ $p$P$x "
  double="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir\n$g║ $B\n$g╚ $p$P$x "

  if (( ${#countme} > PROMPT_MAX )); then
    PS1="$double"
  elif (( ${#countme} > PROMPT_LONG )); then
    PS1="$long"
  else
    PS1="$short"
  fi
}

PROMPT_COMMAND="__ps1"

################################## VIM #################################

## vi-mode for shell
set -o vi

_have vi && export EDITOR=vi; export VISUAL=vi; export EDITOR_PREFIX=vi;
_have vim && export EDITOR=vim; export VISUAL=vim; export EDITOR_PREFIX=vim;

[[ -d $HOME/.vim/spell ]] && export VIMSPELL=("$HOME/.vim/spell/*.add")

############################# SUBPROCS SUCK ############################

perg() {
  declare exp="$1"; shift
  if [[ -z "$*" ]]; then
    while IFS= read -r line; do
      [[ $line =~ $exp ]] && echo "$line"
    done
    return
  fi
  for file in $*; do
    while IFS= read -r line; do
      [[ $line =~ $exp ]] && echo "$line"
    done < "$file"
  done
}
lower() {
  echo ${1,,}
}
upper() {
  echo ${1^^}
}
linecount() {
   IFS=$'\n'
   declare a=($1)
   echo ${#a[@]}
}
# These are so much faster than basename and dirname.
basepart() {
  echo ${1##*/}
}
dirpart() {
  echo ${1%/*}
}
# A friendlier cat that does not invoke a subshell.
kat() {
	declare line
  if [[ -z "$*" ]]; then
    while IFS= read -r line; do
      [[ $line =~ $exp ]] && echo "$line"
    done
    return
  fi
  for file in $*; do
    while IFS= read -r line; do
      echo "$line"
    done < "$file"
  done
}
# Same as kat but skips blank and lines with optional whitespace that
# begin with a comment character (#).
katlines() {
  for file in $*; do
    while IFS= read -r line; do
      [[ $line =~ ^\ *(#|$) ]] && continue
      echo "$line"
    done < "$file"
  done
}
# Moves an existing thing to the same path and name but with
# ".preserved.<tstamp>" at the end and echoes the new location. Usually
# preferable to destroying what was previously there. Can be used to roll
# back changes transactionally.
preserve() {
  declare target="${1%/}"
  [[ ! -e "$target" ]] && return 1
  declare new="$target.preserved.$(tstamp)"
  mv "$target" "$new"
  echo "$new"
}
# Lists all the preserved files by matching the .preserved<tstamp> suffix.
# If passed an argument limits to only those preserved files matching that
# name (prefix).
lspreserved() {
  declare -a files
  if [[ -z "$1" ]]; then
      files=(*.preserved.[2-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])
  else
      files=("$1".preserved.[2-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])
  fi
  for i in "${files[@]}"; do
    echo "$i"
  done
}
lastpreserved() {
  mapfile -t  a < <(lspreserved "$1")
  declare n=${#a[@]}
  echo "${a[n-1]}"
}
rmpreserved() {
  while IFS= read -r line; do
    rm -rf "$line"
  done < <(lspreserved)
}
# Undos the last preserve performed on the given target.
unpreserve() {
  declare last=$(lastpreserved "$*")
  [[ -z "$last" ]] && return 1
  mv "$last" "${last%.preserved*}"
}
trash() {
  [[ -z "$TRASH" ]] && return 1
  mkdir -p "$TRASH"
  mv "$*" "$TRASH"
}
stringscan() {
  declare buf="$1"
  declare handle=(echo)
  [[ -n "$2" ]] && handle=($2)
  for (( i=0; i<${#buf}; i++ )); do
    ($handle ${buf:$i:1})
  done
}
firstline() {
  declare line
  declare IFS=
  read -r line <"$1"
  echo $line
}
lastline() {
  # Tail is fastest because it does a seek to the end of file.
  tail -1 "$1"
}
lastcmdline() {
  lastline "$HOME/.bash_history"
}
lastcmd() {
  declare cl=$(lastcmdline)
  echo ${cl%% *}
}

############################### DIRCOLORS ##############################

if _have dircolors; then
  if [ -r ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

############################## COMPLETION ##############################
# Most completion is set near the function that uses it or internally inside
# the command itself using https://github.com/rwxrob/cmdtab for completion.

if [ -r /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

owncomp=( pdf yt zet sshkey gm lorem tidder )
for i in "${owncomp[@]}"; do complete -C "$i" "$i"; done

## if gh-cli auto complete should not work:
## deactivate gh completion
_have gh && . <(gh completion -s bash)
_have pandoc && . <(pandoc --bash-completion)
#_have spotify && . <(spotify completion bash 2>/dev/null)
#_have podman && _source_if "$HOME/.local/share/podman/completion" # d
_have docker && _source_if "$HOME/.local/share/docker/completion" # d
_have docker-compose && complete -F _docker_compose dc # dc
_have deno && source /usr/local/etc/bash_completion.d/deno.bash

############################ Gruvbox Colors ############################

gruv () {
  printf "     "
  for fore in ${solbases[@]} ${solcolors[@]} ;do
    declare c=sol$fore
    printf "%-4s" $fore
  done
  printf $reset
  for back in ${solbases[@]} ${solcolors[@]};do
    declare b=sol${back^^}
    printf "$reset\n %-4s%s" ${back^^} ${!b}
    for fore in ${solbases[@]} ${solcolors[@]};do
      declare f=sol${fore}
      printf "%s%s%-4s" ${!b} ${!f} sol
    done
  done
  printf $reset
  printf "\n[reset clear]\n"
}

## theme
#theme gruvbox-original-dark-medium

########################### FOREGROUND-COLORS ##########################

export black=$'\033[30m'
export red=$'\033[31m'
export green=$'\033[32m'
export yellow=$'\033[33m'
export blue=$'\033[34m'
export magenta=$'\033[35m'
export cyan=$'\033[36m'
export white=$'\033[37m'

######################### Terminal ANSI Escapes ########################

export escape=$'\033'
export reset=$'\033[0m'
export bold=$'\033[1m'
export underline=$'\033[4m'
export blinkon=$'\033[5m'
export blinkoff=$'\033[25m'
export inverse=$'\033[7m'
export inverseoff=$'\033[27m'
export normal=$'\033[39m'
export normalbg=$'\033[49m'

############################ MANPAGES COLORS ###########################

export LESS_TERMCAP_mb=$magenta
export LESS_TERMCAP_md=$yellow
export LESS_TERMCAP_me=$reset
export LESS_TERMCAP_se=$reset
export LESS_TERMCAP_so=$blue
export LESS_TERMCAP_ue=$reset
export LESS_TERMCAP_us=$underline

############################## TLDR-COLORS #############################

export TLDR_HEADER='magenta bold underline'
export TLDR_QUOTE='italic'
export TLDR_DESCRIPTION='default'
export TLDR_CODE='red'
export TLDR_PARAM='blue'

################################ PYTHON ################################

## no more annoying cache files
export PYTHONDONTWRITEBYTECODE=1

############################ Go Development ############################

# Not being able to use private repos by default with Go is really
# annoying. This is the standard way to overcome that.

export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
export GOBIN="$HOME/.local/go/bin"
mkdir -p $GOBIN
export GOPATH="$HOME/.local/go"
export GOPROXY="direct"
export CGO_ENABLED=0

# Changes into the first Go directory (from GOPATH) matching the name
# passed by looking up the package by specifying the ending string of the
# package name. Prompts for selection if more than one match.  Useful for
# quickly examining the source code of any Go package on the local system.
# (Because this needs to change the current working directory it is
# better as an exported Bash function than a script.)

gocd () {
  local q="$1"
  local list=$(go list -f '{{.Dir}}' ...$q 2>/dev/null)
  IFS=$'\n' local lines=($list) # split lines
  case "${#lines}" in
    0) telln 'Nothing found for "`'$q'`"' ;;
    1) cd $n ;;
    *) select path in "${lines[@]}"; do cd $path; break; done ;;
  esac
}

############################## All Aliases #############################
#      (use exec scripts instead, which work from vim and subprocs)

unalias -a
alias temp='cd $(mktemp -d)'
alias more='less -R'
alias clear='printf "\e[H\e[2J"'
alias c="printf  $'\033[2J\033[;H'" # clear
alias mv='mv -n' # sets noclobber: moving existing files won't get deleted
alias egrep='egrep -i --colour=auto'
alias fgrep='fgrep -i --colour=auto'
alias sudo='sudo '
alias visudo='EDITOR=/usr/bin/vim visudo'
alias free='free -h'
alias df='df -h'
alias syserrors="sudo journalctl -p 3 -xb"
alias sysderrors="sudo systemctl --failed"
alias chmox="chmod u+x"
_have pcregrep && alias grep='pcregrep' || alias grep='grep -i --colour=auto'
_have curl && alias curl='curl -L'
_have dust && alias du='dust'
_have vim && alias vi='vim'
_have emacs && alias emacs='emacs -nw'
_have neomutt && alias mutt='neomutt'
_have libreoffice && alias doc='libreoffice'
_have mupdf && alias mupdf='mupdf -I'
_have vlc && alias vlc='/usr/bin/vlc'
_have neo && alias neo='neo -D -c gold'
_have bashtop && alias top='bashtop'
_have browser-sync && alias browsersync='browser-sync start --server --files "*.html, \
  css/*.css"'
_have reddio && alias ra='reddio | boxes -d dog | less'
_have spotify && alias spotify="env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify %U &"

alias s=searx
alias ?=duck
alias ??=stackexchange
alias ipinfo="curl ipinfo.io"
alias rec='asciinema rec'

############################ ALIAS GIT ########################################
## if $git rm -r is not enough:
alias gri='git ls-files --ignored --exclude-standard | xargs -0 git rm -r'
alias ga='git add'
alias gs='git status'
alias gpl='git pull'
alias gps='git push'
alias gc='git commit'
alias gg='git graph'
alias gview='git log --graph --full-history --all --pretty=format:"%h%x09%d%x20%s" --simplify-by-decoration'
alias gbigfiles='git rev-list --all | xargs -rL1 git ls-tree -r --long | sort -uk3 | sort -rnk4 | less'
alias gd='git diff'
alias gsu='git stash && git pull && git stash pop'
alias gdl='git log --diff-filter=D --summary | grep delete'

############################## ALIAS LS #######################################
alias ls='ls -h --color=auto'
alias lsplain='ls -h --color=never'
alias lx='ls -AlXB'    #  Sort by extension.
alias lxr='ls -ARlXB'  #  Sort by extension.
alias lk='ls -AlSr'    #  Sort by size, biggest last.
alias lkr='ls -ARlSr'  #  Sort by size, biggest last.
alias lt='ls -Altr'    #  Sort by date, most recent last.
alias ltr='ls -ARltr'  #  Sort by date, most recent last.
alias lc='ls -Altcr'   #  Sort by change time, most recent last.
alias lcr='ls -ARltcr' #  Sort by change time, most recent last.
alias lu='ls -Altur'   #  Sort by access time, most recent last.
alias lur='ls -ARltur' #  Sort by access time, most recent last.
alias ll='ls -Alhv'    #  A better long listing.
alias llr='ls -ARlhv'  #  Recursive long listing.
alias lr='ll -AR'      #  Recursive simple ls.
alias lm='ls |more'    #  Pipe through 'more'
alias lmr='lr |more'   #  Pipe through 'more'

############################### FUNCTIONS ##############################

clone() {
  local repo="$1" user
  local repo="${repo#https://github.com/}"
  local repo="${repo#git@github.com:}"
  if [[ $repo =~ / ]]; then
    user="${repo%%/*}"
  else
    user="$GITUSER"
    [[ -z "$user" ]] && user="$USER"
  fi
  local name="${repo##*/}"
  local userd="$REPOS/github.com/$user"
  local path="$userd/$name"
  [[ -d "$path" ]] && cd "$path" && return
  mkdir -p "$userd"
  cd "$userd"
  echo gh repo clone "$user/$name" -- --recurse-submodule
  gh repo clone "$user/$name" -- --recurse-submodule
  cd "$name"
} && export -f clone

envx() {
  local envfile="${1:-"$HOME/.env"}"
  [[ ! -e "$envfile" ]] && echo "$envfile not found" && return 1
  while IFS= read -r line; do
    name=${line%%=*}
    value=${line#*=}
    [[ -z "${name}" || $name =~ ^# ]] && continue
    export "$name"="$value"
  done < "$envfile"
} && export -f envx

[[ -e "$HOME/.env" ]] && envx "$HOME/.env"

cdz () { cd $(zet get "$@"); }

############################### PERSONAL ###############################

_source_if "$HOME/.bash_personal"
_source_if "$HOME/.bash_private"
_source_if "$HOME/.bash_work"
