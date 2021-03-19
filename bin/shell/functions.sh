
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
  if [[ $# -eq 1 ]]; then
    git clone git@gitlab.com:xnasero-private/www-template.git $1 && cd $_
    rm -rf .git
  else
    git clone git@gitlab.com:xnasero-private/www-template.git && cd www-template/
    rm -rf .git
  fi
}
