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

for dir in repos downloads pictures; do
  upper=${dir^^}
  cap=${dir^}
  if [ -d "$HOME/$cap" ]; then
    eval "export $upper='$HOME/$cap'"
  elif [ -d "$HOME/$dir" ]; then
    eval "export $upper='$HOME/$dir'"
  fi
done
