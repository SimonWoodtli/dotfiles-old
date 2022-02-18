
################################### FUNCTIONS ###########################

## awesome cheatsheet!!
cheat () {
  where="$1"; shift
  IFS=+ curl "http://cht.sh/$where/ $*"
} && export -f cheat


search () {
        if [ -n "$1" ]; then
                if [ -n "$2" ]; then
                        find $1 -iname *$2*
                else
                        find / -iname *$1*
                fi
        else
                echo "Usage: search [dir] [partial_file_name]"
        fi
}

extract () {
    if [ -n "$1" ] ; then
        if [ -f $1 ] ; then
                case $1 in
                *.tar.bz2) tar xjf $1 ;;
                *.tar.gz) tar xzf $1 ;;
                *.bz2) bunzip2 $1 ;;
                *.rar) rar x $1 ;;
                *.gz) gunzip $1 ;;
                *.tar) tar xf $1 ;;
                *.tbz2) tar xjf $1 ;;
                *.tgz) tar xzf $1 ;;
                *.zip) unzip $1 ;;
                *.Z) uncompress $1 ;;
                *.7z) 7z x $1 ;;
                *) echo "'$1' cannot be extracted via extract" ;;
                esac
        else
                echo "'$1' is not a valid file"
        fi
    else
        echo "Usage: extract filename"
    fi
}

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
  if [[ $# -eq 1 ]]; then
    gh repo clone SimonWoodtli/www-template $1 && cd $_
    rm -rf .git
  else
    gh repo clone SimonWoodtli/www-template && cd www-template/
    rm -rf .git
  fi
}

#### GIT ####

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

gmr() {
  if [ "$#" -eq 1 ]; then
    git merge $1 --no-ff
  else
    echo "Please provide a single argument: gmr \$1"
  fi
}

gck() {
  if [ "$#" -eq 1 ]; then
    branches=($(git branch | cut -c 3-))
    for branch in "${branches[@]}"; do
      if [[ "${branch}" = $1 ]]; then
        git checkout $1
        echo "Switched to an existing branch: ${branch}"
        return 0
      fi
    done
    echo "Created and switched to a new branch: $1"
    git checkout -b $1
  else
    echo "Please provide a single argument: gck \$1"
  fi
}
