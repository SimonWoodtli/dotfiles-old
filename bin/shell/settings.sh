
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
