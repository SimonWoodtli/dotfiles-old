#########################################################################
#______  ___   _____ _   _ ______  _____
#| ___ \/ _ \ /  ___| | | || ___ \/  __ \
#| |_/ / /_\ \\ `--.| |_| || |_/ /| /  \/
#| ___ \  _  | `--. \  _  ||    / | |
#| |_/ / | | |/\__/ / | | || |\ \ | \__/\
#\____/\_| |_/\____/\_| |_/\_| \_| \____/
#
#########################################################################



############################# DETECTION #################################

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

onmac () {
  [ "$PLATFORM" = mac ] && return 0
  return 1
}

onwin () {
  [ "$PLATFORM" == windows ]  && return 0
  return 1
}

onlinux () {
  [ "$PLATFORM" == linux ]  && return 0
  return 1
}

onunknown () {
  [ "$PLATFORM" == unknown ]  && return 0
  return 1
}

havecmd () {
  type "$1" &> /dev/null
  return $?
}

## FIXME
for dir in repos downloads pictures; do
  upper=${dir^^}
  cap=${dir^}
  if [ -z "${!upper}" ]; then
    if [ -d "$HOME/$cap" ]; then
      eval "export $upper='$HOME/$cap'"
    elif [ -d "$HOME/$dir" ]; then
      eval "export $upper='$HOME/$dir'"
    elif [ -d "$HOME/.local/$dir" ]; then
      eval "export $upper='$HOME/.local/$dir'"
    elif [ -d "$HOME/.local/$dir" ]; then
      eval "export $upper='$HOME/$dir'"
    fi
  fi
done

################################# GIT ###################################
havecmd git && export GITUSER="$(git config --global user.name)"

################################ EXPORTS ################################

export BROWSER=/usr/bin/lynx

## used for `pdf` script
export PDFDIR=$HOME/Repos/gitlab.com/$GITUSER/books/work/essentials

## IBUS config for chinese pinyin input
export GTK_IM_MODULE=IBUS
export XMODIFIERS=@im=IBUS
export QT_IM_MODULE=IBUS

## not sure if I still need this:
#VERSION=v12.18.1
#DISTRO=linux-x64
#export PATH=/usr/local/lib/nodejs/node-$VERSION-/bin:$PATH

############################# Export PATH ###############################

export DENO_INSTALL="$HOME/.deno"

export SCRIPTS=\
$REPOS/gitlab.com/$GITUSER/dotfiles/scripts:\
$REPOS/github.com/$GITUSER/dotfiles/scripts

export SCRIPTS_PRIV=\
$REPOS/gitlab.com/$GITUSER/dotfiles/scripts_private:\
$REPOS/github.com/$GITUSER/dotfiles/scripts_private

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
$REPOS/gitlab.com/$GITUSER:\
$REPOS/github.com/$GITUSER:\
$REPOS/gitlab.com/$GITUSER/dotfiles:\
$REPOS/gitlab.com/$GITUSER/pdfs:\
$REPOS/gitlab.com/$GITUSER/notes:\
$REPOS/gitlab.com/*:\
$REPOS/github.com/*:\
$REPOS/gitlab.com:\
$REPOS/github.com:\
$REPOS:\
/media/$USER:\
$HOME

#################################### SETTINGS ###########################

#set -o noclobber            # paranoid? use >| for everything
shopt -s checkwinsize
shopt -s expand_aliases
#shopt -s nullglob # creates bug FIX ME

## glovestar: (ls **filename includes subdirectories):
shopt -s globstar
## dotglob: the star (*) by default ignores the dot,
## with this setting the dot gets listed:
shopt -s dotglob

shopt -s extglob
shopt -s histappend

shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s histappend # do not overwrite history
shopt -s checkwinsize # checks term size when bash regains control

HISTCONTROL=ignoreboth
## Ignore duplicates in command history
#HISTCONTROL=ignoredups
## increase default 500 commands to 5000
HISTSIZE=5000
HISTFILESIZE=10000

#setxkbmap -option ctrl:ctrl_modifier # map capslock to control

## ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"


export HRULEWIDTH=73

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

################################ CMD PROMPT #############################

export glypharrow=$'\ue0b0'
export glyphflames=$'\ue0c0'
export glyphrounded=$'\ue0b4'
export glyphbits=$'\ue0c6'
export glyphhex=$'\ue0cc'

export PS1w=$'\033[38;5;33m'
export PS1u=$'\033[38;2;0;165;0m'
export PS1a=$'\033[38;2;100;100;100m'
export PS1c=$'\033[38;2;110;110;110m'
export PS1h=$'\033[38;2;169;112;255m'
export PS1p=$'\033[38;2;218;165;32m'
export PS1P=$'\033[38;2;255;0;0m'
export PS1U=$PS1P

export gruv_orange=$'\033[38;2;214;93;13m'

if [[ $EUID == 0 ]]; then
  export PS1='\[$PS1U\]\u\[$PS1a\]@\[$PS1h\]\h\[$PS1c\]:\[$PS1w\]\w\[$PS1P\]#\[\033[00m\] '
else
  export PS1='\[$PS1u\]\u\[$PS1a\]@\[$PS1h\]\h\[$PS1c\]:\[$PS1w\]\w\[$PS1p\]$\[\033[00m\] '
fi

ps1min () {
  export PS1='\[$gruv_orange\]$\[\033[00m\] '
}

##################################### VIM ###############################

## vi-mode for shell
set -o vi

export EDITOR=vi
export VISUAL=vi
export EDITOR_PREFIX=vi

export VIMSPELL=(~/.vim/spell/*.add)
declare personalspell=(~/.vimpersonal/spell/*.add)
[ -n "$personalspell" ] && VIMSPELL=$personalspell
declare privatespell=(~/.vimprivate/spell/*.add)
[ -n $privatespell ] && VIMSPELL=$privatespell

######################################## PYTHON #########################

## no more annoying cache files
export PYTHONDONTWRITEBYTECODE=1

############################# SUBPROCS SUCK #############################

perg () {
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

lower () {
  echo ${1,,}
}

upper () {
  echo ${1^^}
}

linecount () {
   IFS=$'\n'
   declare a=($1)
   echo ${#a[@]}
}

# These are so much faster than basename and dirname.

basepart () {
  echo ${1##*/}
}

dirpart () {
  echo ${1%/*}
}


# A friendlier cat that does not invoke a subshell.

kat () {
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

katlines () {
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

preserve () {
  declare target="${1%/}"
  [[ ! -e "$target" ]] && return 1
  declare new="$target.preserved.$(tstamp)"
  mv "$target" "$new"
  echo "$new"
}

# Lists all the preserved files by matching the .preserved<tstamp> suffix.
# If passed an argument limits to only those preserved files matching that
# name (prefix).

lspreserved () {
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

lastpreserved () {
  mapfile -t  a < <(lspreserved "$1")
  declare n=${#a[@]}
  echo "${a[n-1]}"
}

rmpreserved () {
  while IFS= read -r line; do
    rm -rf "$line"
  done < <(lspreserved)
}

# Undos the last preserve performed on the given target.

unpreserve () {
  declare last=$(lastpreserved "$*")
  [[ -z "$last" ]] && return 1
  mv "$last" "${last%.preserved*}"
}

trash () {
  [[ -z "$TRASH" ]] && return 1
  mkdir -p "$TRASH"
  mv "$*" "$TRASH"
}

stringscan () {
  declare buf="$1"
  declare handle=(echo)
  [[ -n "$2" ]] && handle=($2)
  for (( i=0; i<${#buf}; i++ )); do
    ($handle ${buf:$i:1})
  done
}

firstline () {
  declare line
  declare IFS=
  read -r line <"$1"
  echo $line
}

lastline () {
  # Tail is fastest because it does a seek to the end of file.
  tail -1 "$1"
}

lastcmdline () {
  lastline "$HOME/.bash_history"
}

lastcmd () {
  declare cl=$(lastcmdline)
  echo ${cl%% *}
}

################################ DIRCOLORS ##############################

if which dircolors &>/dev/null; then
  if [ -r ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

## older version:

#if havecmd dircolors; then
#  if [ -r ~/.dircolors ]; then
#    eval "$(dircolors -b ~/.dircolors)"
#  else
#    eval "$(dircolors -b)"
#  fi
#fi

################################ TRAP ###################################

trapterm () {
  declare handler="$1"
  # TODO replace this with a pop/push alternative to preserve keep others
  trap "$handler; echo $'\b\b'; trap -- - SIGINT SIGTERM" SIGTERM SIGINT
}

################################# COMPLETION ############################

# Most completion is set near the function that uses it or internally inside
# the command itself using https://github.com/robmuh/cmdtab for completion.

if [ -r /usr/share/bash-completion/bash_completion ]; then
  source /usr/share/bash-completion/bash_completion
fi

## needed to make pdf script work
complete -C pdf pdf

complete -C md md
complete -C yt yt
complete -C gl gl
complete -C kn kn
complete -C auth auth
complete -C live live
complete -C wsutil wsutil

eval "$(gh completion -s bash)"
eval "$(pandoc --bash-completion)"

############################ Gruvbox Colors #############################

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
theme gruvbox-original-dark-medium

############################ FOREGROUND-COLORS ############################

export black=$'\033[30m'
export red=$'\033[31m'
export green=$'\033[32m'
export yellow=$'\033[33m'
export blue=$'\033[34m'
export magenta=$'\033[35m'
export cyan=$'\033[36m'
export white=$'\033[37m'

############################## MANPAGES COLORS ##########################

export LESS_TERMCAP_mb=$magen
export LESS_TERMCAP_md=$yellow
export LESS_TERMCAP_me=$reset
export LESS_TERMCAP_se=$reset
export LESS_TERMCAP_so=$blue
export LESS_TERMCAP_ue=$reset
export LESS_TERMCAP_us=$'\033[4m'

################################ TLDR-COLORS ############################

export TLDR_HEADER='magenta bold underline'
export TLDR_QUOTE='italic'
export TLDR_DESCRIPTION='default'
export TLDR_CODE='red'
export TLDR_PARAM='blue'

############################# Go Development #############################

# Not being able to use private repos by default with Go is really
# annoying. This is the standard way to overcome that.

export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
export GOBIN="$HOME/.local/go/bin"
mkdir -p $GOBIN
export GOPATH="$HOME/.local/go"
export GOPROXY="direct"

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

############################# LOCAL SETTINGS ############################
[ -r ~/.bash_personal   ] && source ~/.bash_personal
[ -r ~/.bash_private   ] && source ~/.bash_private

############################## All Aliases ##############################
unalias -a
alias more='less -R'
alias c='clear'
## sets noclobber for mv so you don't delete file when moving them to
## existing place
alias mv='mv -n'

alias grep='grep -i --colour=auto'
alias egrep='egrep -i --colour=auto'
alias fgrep='fgrep -i --colour=auto'
alias curl='curl -L'

alias sudo='sudo '
alias visudo='EDITOR=/usr/bin/vim visudo'

alias ssh-keygen='ssh-keygen -t ed25519'

alias s=searx0
alias ?=duck
alias ??=stackexchange

alias bat='\
  upower -i /org/freedesktop/UPower/devices/battery_BAT0 | \
  grep -E "state|to\ full|percentage"'
alias free='free -h'
alias df='df -h'
alias syserrors="sudo journalctl -p 3 -xb"
alias sysderrors="sudo systemctl --failed"
alias chmox="chmod u+x"

alias vi='vim'
alias emacs='emacs -nw'
alias mutt='neomutt'
alias doc='libreoffice'
alias mupdf='mupdf -I'
alias top='htop'
alias vlc='flatpak run org.videolan.VLC'
alias browsersync='browser-sync start --server --files "*.html, \
  css/*.css"'
alias ra='reddio | boxes -d dog | less'
alias spotify="LD_PRELOAD=/usr/local/lib/spotify-adblock.so flatpak run \
  com.spotify.Client &"
alias rec='asciinema rec'
alias surf="surf -F -z 1.5 duckduckgo.com & disown"


alias ipinfo="curl ipinfo.io"
alias weather="curl wttr.in"

#alias com='complete -W "$(tldr 2>/dev/null --list)"'


################################### GIT ##################################
## if $git rm -r is not enough:
alias gri='git ls-files --ignored --exclude-standard | xargs -0 git rm -r'

alias ga='git add'
alias gs='git status'
alias gpl='git pull'
alias gps='git push'
alias gc='git commit'
alias gg='git graph'
alias gd='git diff'
alias gsu='git stash && git pull && git stash pop'
alias gdl='git log --diff-filter=D --summary | grep delete'

################################### LS ##################################
alias ls='ls -h --color=auto'
#alias ll="ls -la"
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

################################### FUNCTIONS ###########################

## awesome cheatsheet!!
cheat () {
  where="$1"; shift
  IFS=+ curl "http://cht.sh/$where/ $*"
} && export -f cheat

envx () {
  local envfile="$1"
  if [[ ! -e "${envfile}" ]]; then
    if [[ ! -e "$HOME/.env" ]]; then
      echo "file not found: ${envfile}"
      return
    fi
    envfile="$HOME/.env"
  fi
  while IFS= read line; do
    name=${line%%=*}
    value=${line#*=}
    if [[ -z "${name}" || $name =~ ^# ]]; then
      continue
    fi
    export "$name"="$value"
  done < "${envfile}"
} && export -f envx

if [[ -e "$HOME/.env" ]]; then
  envx $HOME/.env
fi

## open executable file wherever it is with "vic"
vic () {
  vi $(which $1);
}

## if you forgot sudo you can just run `please` or just default: `sudo !!`
please() {
  if [ "$1" ]; then
    sudo $@
  else
    sudo "$BASH" -c "$(history -p !!)"
  fi
}

## list all current files in git repo by size
glist() {
  git rev-list --objects --all \
| git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
| awk '/^blob/ {print substr($0,6)}' \
| sort --numeric-sort --key=2 \
| cut --complement --characters=13-40 \
| numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}

## 1. run `gdl` list path of all deleted files
## 2. `gshowdl` -> list all commits that have a deleted file, $1=<path-to-deleted-file>
## 3. `git show <commit-id> -- <path-to-deleted-file>` -> for details
gshowdl() {
  git log --all -- "$1"
}

rc() {
  reddio print comments/$1 | less
}

rtm() {
  reddio print -l 10 -t month r/$1/top | boxes -d dog | less
}
rtw() {
  reddio print -l 10 -t week r/$1/top | boxes -d dog | less
}

rn() {
  reddio print -l 10 r/$1 | boxes -d dog | less
}

htmlcheck() {
  html5validator --root --show-warnings $3
}

csscheck() {
  html5validator --root --show-warnings $1 --skip-non-css
}

template() {
  git clone git@gitlab.com:xnasero-private/www-template.git $1 && cd $_
  rm -rf .git
}

################################# ARCH ##################################

cleanup() {
  sudo pacman -Rsn $(pacman -Qdtq) # removes orphant packages
  sudo pacman -Sc # removes all uninstalled packages from cache
}

##################################### EMOJI #############################

## emoji array
emojis=(🤖 👾 🤮 🤑 🤡 💩 👽 🥳 🤩 🤣 🤔 🖖 🙏 🧘 🛹 🛶 🥊 🎿 🎸  🤹  🐶 🐹 🐰 🦊 🐻 🐼 🐨 🐯 🦁
🐷 🐸 🐔 🐧 🐄 🦘 🦭     🦊 🐻  🦦 🦥 🦩 🐋 🐬 🐡 🐝 🌱 🦀 🦙 🦒 🐑 🐣 🦖 🦬    🦨 🐉 🦤    🐁 🦫    🐙 🦑 🐞 🪰    🐛 🦄 🐍 🐢 🐇 🦧 🦓 🦣   🌈   🥑 🥦 🍎 🥝 🍍 🍣)

emoji() {
  grabEmoji=${emojis[$RANDOM % ${#emojis[@]}]};
  echo $grabEmoji;
}
