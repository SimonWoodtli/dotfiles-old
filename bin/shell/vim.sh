
##################################### VIM ###############################

## vi-mode for shell
set -o vi

if [ $(which vi 2> /dev/null) ]; then
  { export EDITOR=vi; export VISUAL=vi; export EDITOR_PREFIX=vi; }
elif [ $(which vim 2> /dev/null) ]; then
  { export EDITOR=vim; export VISUAL=vim; export EDITOR_PREFIX=vim; }
fi

export VIMSPELL=(~/.vim/spell/*.add)
declare personalspell=(~/.vimpersonal/spell/*.add)
[ -n "$personalspell" ] && VIMSPELL=$personalspell
declare privatespell=(~/.vimprivate/spell/*.add)
[ -n $privatespell ] && VIMSPELL=$privatespell
