
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
