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

for dir in repos downloads pictures; do
  upper=${dir^^}
  cap=${dir^}
  if [ -d "$HOME/$cap" ]; then
    eval "export $upper='$HOME/$cap'"
  elif [ -d "$HOME/$dir" ]; then
    eval "export $upper='$HOME/$dir'"
  fi
done

################################# GIT ###################################
havecmd git && export GITUSER="$(git config --global user.name)"

################################ EXPORTS ################################

export BROWSER=/usr/sbin/librewolf

## used for `pdf` script
export PDFDIR=$HOME/repos/github.com/$GITUSER/books/work/essentials

## used for `zet` script
export KN=$HOME/repos/github.com/$GITUSER/knowledge

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
$REPOS/github.com/$GITUSER/dotfiles/scripts:\
$REPOS/gitlab.com/$GITUSER/dotfiles/scripts/substitute-alias:\
$REPOS/github.com/$GITUSER/dotfiles/scripts/substitute-alias

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
$REPOS/github.com/$GITUSER/dotfiles:\
$REPOS/github.com/$GITUSER/books:\
$REPOS/github.com/$GITUSER/knowledge:\
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
# bash/zsh git prompt support
#
# Copyright (C) 2006,2007 Shawn O. Pearce <spearce@spearce.org>
# Distributed under the GNU General Public License, version 2.0.
#
# This script allows you to see repository status in your prompt.
#
# To enable:
#
#    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
#    2) Add the following line to your .bashrc/.zshrc:
#        source ~/.git-prompt.sh
#    3a) Change your PS1 to call __git_ps1 as
#        command-substitution:
#        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#        ZSH:  setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
#        the optional argument will be used as format string.
#    3b) Alternatively, for a slightly faster prompt, __git_ps1 can
#        be used for PROMPT_COMMAND in Bash or for precmd() in Zsh
#        with two parameters, <pre> and <post>, which are strings
#        you would put in $PS1 before and after the status string
#        generated by the git-prompt machinery.  e.g.
#        Bash: PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
#          will show username, at-sign, host, colon, cwd, then
#          various status string, followed by dollar and SP, as
#          your prompt.
#        ZSH:  precmd () { __git_ps1 "%n" ":%~$ " "|%s" }
#          will show username, pipe, then various status string,
#          followed by colon, cwd, dollar and SP, as your prompt.
#        Optionally, you can supply a third argument with a printf
#        format string to finetune the output of the branch status
#
# The repository status will be displayed only if you are currently in a
# git repository. The %s token is the placeholder for the shown status.
#
# The prompt status always includes the current branch name.
#
# In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
# unstaged (*) and staged (+) changes will be shown next to the branch
# name.  You can configure this per-repository with the
# bash.showDirtyState variable, which defaults to true once
# GIT_PS1_SHOWDIRTYSTATE is enabled.
#
# You can also see if currently something is stashed, by setting
# GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
# then a '$' will be shown next to the branch name.
#
# If you would like to see if there're untracked files, then you can set
# GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're untracked
# files, then a '%' will be shown next to the branch name.  You can
# configure this per-repository with the bash.showUntrackedFiles
# variable, which defaults to true once GIT_PS1_SHOWUNTRACKEDFILES is
# enabled.
#
# If you would like to see the difference between HEAD and its upstream,
# set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
# indicates you are ahead, "<>" indicates you have diverged and "="
# indicates that there is no difference. You can further control
# behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated list
# of values:
#
#     verbose       show number of commits ahead/behind (+/-) upstream
#     name          if verbose, then also show the upstream abbrev name
#     legacy        don't use the '--count' option available in recent
#                   versions of git-rev-list
#     git           always compare HEAD to @{upstream}
#     svn           always compare HEAD to your SVN upstream
#
# You can change the separator between the branch name and the above
# state symbols by setting GIT_PS1_STATESEPARATOR. The default separator
# is SP.
#
# When there is an in-progress operation such as a merge, rebase,
# revert, cherry-pick, or bisect, the prompt will include information
# related to the operation, often in the form "|<OPERATION-NAME>".
#
# When the repository has a sparse-checkout, a notification of the form
# "|SPARSE" will be included in the prompt.  This can be shortened to a
# single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitted
# by setting GIT_PS1_OMITSPARSESTATE.
#
# By default, __git_ps1 will compare HEAD to your SVN upstream if it can
# find one, or @{upstream} otherwise.  Once you have set
# GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
# setting the bash.showUpstream config variable.
#
# If you would like to see more information about the identity of
# commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
# to one of these values:
#
#     contains      relative to newer annotated tag (v1.6.3.2~35)
#     branch        relative to newer tag or branch (master~4)
#     describe      relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
#     tag           relative to any older tag (v1.6.3.1-13-gdd42c2f)
#     default       exactly matching tag
#
# If you would like a colored hint about the current dirty state, set
# GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
# the colored output of "git status -sb" and are available only when
# using __git_ps1 for PROMPT_COMMAND or precmd in Bash,
# but always available in Zsh.
#
# If you would like __git_ps1 to do nothing in the case when the current
# directory is set up to be ignored by git, then set
# GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
# repository level by setting bash.hideIfPwdIgnored to "false".

# check whether printf supports -v
__git_printf_supports_v=
printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1

# stores the divergence from upstream in $p
# used by GIT_PS1_SHOWUPSTREAM
__git_ps1_show_upstream ()
{
	local key value
	local svn_remote svn_url_pattern count n
	local upstream=git legacy="" verbose="" name=""

	svn_remote=()
	# get some config options from git-config
	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
	while read -r key value; do
		case "$key" in
		bash.showupstream)
			GIT_PS1_SHOWUPSTREAM="$value"
			if [[ -z "${GIT_PS1_SHOWUPSTREAM}" ]]; then
				p=""
				return
			fi
			;;
		svn-remote.*.url)
			svn_remote[$((${#svn_remote[@]} + 1))]="$value"
			svn_url_pattern="$svn_url_pattern\\|$value"
			upstream=svn+git # default upstream is SVN if available, else git
			;;
		esac
	done <<< "$output"

	# parse configuration values
	local option
	for option in ${GIT_PS1_SHOWUPSTREAM}; do
		case "$option" in
		git|svn) upstream="$option" ;;
		verbose) verbose=1 ;;
		legacy)  legacy=1  ;;
		name)    name=1 ;;
		esac
	done

	# Find our upstream
	case "$upstream" in
	git)    upstream="@{upstream}" ;;
	svn*)
		# get the upstream from the "git-svn-id: ..." in a commit message
		# (git-svn uses essentially the same procedure internally)
		local -a svn_upstream
		svn_upstream=($(git log --first-parent -1 \
					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
			svn_upstream=${svn_upstream[${#svn_upstream[@]} - 2]}
			svn_upstream=${svn_upstream%@*}
			local n_stop="${#svn_remote[@]}"
			for ((n=1; n <= n_stop; n++)); do
				svn_upstream=${svn_upstream#${svn_remote[$n]}}
			done

			if [[ -z "$svn_upstream" ]]; then
				# default branch name for checkouts with no layout:
				upstream=${GIT_SVN_ID:-git-svn}
			else
				upstream=${svn_upstream#/}
			fi
		elif [[ "svn+git" = "$upstream" ]]; then
			upstream="@{upstream}"
		fi
		;;
	esac

	# Find how many commits we are ahead/behind our upstream
	if [[ -z "$legacy" ]]; then
		count="$(git rev-list --count --left-right \
				"$upstream"...HEAD 2>/dev/null)"
	else
		# produce equivalent output to --count for older versions of git
		local commits
		if commits="$(git rev-list --left-right "$upstream"...HEAD 2>/dev/null)"
		then
			local commit behind=0 ahead=0
			for commit in $commits
			do
				case "$commit" in
				"<"*) ((behind++)) ;;
				*)    ((ahead++))  ;;
				esac
			done
			count="$behind	$ahead"
		else
			count=""
		fi
	fi

	# calculate the result
	if [[ -z "$verbose" ]]; then
		case "$count" in
		"") # no upstream
			p="" ;;
		"0	0") # equal to upstream
			p="=" ;;
		"0	"*) # ahead of upstream
			p=">" ;;
		*"	0") # behind upstream
			p="<" ;;
		*)	    # diverged from upstream
			p="<>" ;;
		esac
	else
		case "$count" in
		"") # no upstream
			p="" ;;
		"0	0") # equal to upstream
			p=" u=" ;;
		"0	"*) # ahead of upstream
			p=" u+${count#0	}" ;;
		*"	0") # behind upstream
			p=" u-${count%	0}" ;;
		*)	    # diverged from upstream
			p=" u+${count#*	}-${count%	*}" ;;
		esac
		if [[ -n "$count" && -n "$name" ]]; then
			__git_ps1_upstream_name=$(git rev-parse \
				--abbrev-ref "$upstream" 2>/dev/null)
			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
				p="$p \${__git_ps1_upstream_name}"
			else
				p="$p ${__git_ps1_upstream_name}"
				# not needed anymore; keep user's
				# environment clean
				unset __git_ps1_upstream_name
			fi
		fi
	fi

}

# Helper function that is meant to be called from __git_ps1.  It
# injects color codes into the appropriate gitstring variables used
# to build a gitstring.
__git_ps1_colorize_gitstring ()
{
	if [[ -n ${ZSH_VERSION-} ]]; then
		local c_red='%F{red}'
		local c_green='%F{green}'
		local c_lblue='%F{blue}'
		local c_clear='%f'
	else
		# Using \[ and \] around colors is necessary to prevent
		# issues with command line editing/browsing/completion!
		local c_red='\[\e[31m\]'
		local c_green='\[\e[32m\]'
		local c_lblue='\[\e[1;34m\]'
		local c_clear='\[\e[0m\]'
	fi
	local bad_color=$c_red
	local ok_color=$c_green
	local flags_color="$c_lblue"

	local branch_color=""
	if [ $detached = no ]; then
		branch_color="$ok_color"
	else
		branch_color="$bad_color"
	fi
	c="$branch_color$c"

	z="$c_clear$z"
	if [ "$w" = "*" ]; then
		w="$bad_color$w"
	fi
	if [ -n "$i" ]; then
		i="$ok_color$i"
	fi
	if [ -n "$s" ]; then
		s="$flags_color$s"
	fi
	if [ -n "$u" ]; then
		u="$bad_color$u"
	fi
	r="$c_clear$r"
}

# Helper function to read the first line of a file into a variable.
# __git_eread requires 2 arguments, the file path and the name of the
# variable, in that order.
__git_eread ()
{
	test -r "$1" && IFS=$'\r\n' read "$2" <"$1"
}

# see if a cherry-pick or revert is in progress, if the user has committed a
# conflict resolution with 'git commit' in the middle of a sequence of picks or
# reverts then CHERRY_PICK_HEAD/REVERT_HEAD will not exist so we have to read
# the todo file.
__git_sequencer_status ()
{
	local todo
	if test -f "$g/CHERRY_PICK_HEAD"
	then
		r="|CHERRY-PICKING"
		return 0;
	elif test -f "$g/REVERT_HEAD"
	then
		r="|REVERTING"
		return 0;
	elif __git_eread "$g/sequencer/todo" todo
	then
		case "$todo" in
		p[\ \	]|pick[\ \	]*)
			r="|CHERRY-PICKING"
			return 0
		;;
		revert[\ \	]*)
			r="|REVERTING"
			return 0
		;;
		esac
	fi
	return 1
}

# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
# when called from PS1 using command substitution
# in this mode it prints text to add to bash PS1 prompt (includes branch name)
#
# __git_ps1 requires 2 or 3 arguments when called from PROMPT_COMMAND (pc)
# in that case it _sets_ PS1. The arguments are parts of a PS1 string.
# when two arguments are given, the first is prepended and the second appended
# to the state string when assigned to PS1.
# The optional third parameter will be used as printf format string to further
# customize the output of the git-status string.
# In this mode you can request colored hints using GIT_PS1_SHOWCOLORHINTS=true
__git_ps1 ()
{
	# preserve exit status
	local exit=$?
	local pcmode=no
	local detached=no
	local ps1pc_start='\u@\h:\w '
	local ps1pc_end='\$ '
	local printf_format=' (%s)'

	case "$#" in
		2|3)	pcmode=yes
			ps1pc_start="$1"
			ps1pc_end="$2"
			printf_format="${3:-$printf_format}"
			# set PS1 to a plain prompt so that we can
			# simply return early if the prompt should not
			# be decorated
			PS1="$ps1pc_start$ps1pc_end"
		;;
		0|1)	printf_format="${1:-$printf_format}"
		;;
		*)	return $exit
		;;
	esac

	# ps1_expanded:  This variable is set to 'yes' if the shell
	# subjects the value of PS1 to parameter expansion:
	#
	#   * bash does unless the promptvars option is disabled
	#   * zsh does not unless the PROMPT_SUBST option is set
	#   * POSIX shells always do
	#
	# If the shell would expand the contents of PS1 when drawing
	# the prompt, a raw ref name must not be included in PS1.
	# This protects the user from arbitrary code execution via
	# specially crafted ref names.  For example, a ref named
	# 'refs/heads/$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)' might cause the
	# shell to execute 'sudo rm -rf /' when the prompt is drawn.
	#
	# Instead, the ref name should be placed in a separate global
	# variable (in the __git_ps1_* namespace to avoid colliding
	# with the user's environment) and that variable should be
	# referenced from PS1.  For example:
	#
	#     __git_ps1_foo=$(do_something_to_get_ref_name)
	#     PS1="...stuff...\${__git_ps1_foo}...stuff..."
	#
	# If the shell does not expand the contents of PS1, the raw
	# ref name must be included in PS1.
	#
	# The value of this variable is only relevant when in pcmode.
	#
	# Assume that the shell follows the POSIX specification and
	# expands PS1 unless determined otherwise.  (This is more
	# likely to be correct if the user has a non-bash, non-zsh
	# shell and safer than the alternative if the assumption is
	# incorrect.)
	#
	local ps1_expanded=yes
	[ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=no
	[ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expanded=no

	local repo_info rev_parse_exit_code
	repo_info="$(git rev-parse --git-dir --is-inside-git-dir \
		--is-bare-repository --is-inside-work-tree \
		--short HEAD 2>/dev/null)"
	rev_parse_exit_code="$?"

	if [ -z "$repo_info" ]; then
		return $exit
	fi

	local short_sha=""
	if [ "$rev_parse_exit_code" = "0" ]; then
		short_sha="${repo_info##*$'\n'}"
		repo_info="${repo_info%$'\n'*}"
	fi
	local inside_worktree="${repo_info##*$'\n'}"
	repo_info="${repo_info%$'\n'*}"
	local bare_repo="${repo_info##*$'\n'}"
	repo_info="${repo_info%$'\n'*}"
	local inside_gitdir="${repo_info##*$'\n'}"
	local g="${repo_info%$'\n'*}"

	if [ "true" = "$inside_worktree" ] &&
	   [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED-}" ] &&
	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
	   git check-ignore -q .
	then
		return $exit
	fi

	local sparse=""
	if [ -z "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
	   [ -z "${GIT_PS1_OMITSPARSESTATE}" ] &&
	   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
		sparse="|SPARSE"
	fi

	local r=""
	local b=""
	local step=""
	local total=""
	if [ -d "$g/rebase-merge" ]; then
		__git_eread "$g/rebase-merge/head-name" b
		__git_eread "$g/rebase-merge/msgnum" step
		__git_eread "$g/rebase-merge/end" total
		r="|REBASE"
	else
		if [ -d "$g/rebase-apply" ]; then
			__git_eread "$g/rebase-apply/next" step
			__git_eread "$g/rebase-apply/last" total
			if [ -f "$g/rebase-apply/rebasing" ]; then
				__git_eread "$g/rebase-apply/head-name" b
				r="|REBASE"
			elif [ -f "$g/rebase-apply/applying" ]; then
				r="|AM"
			else
				r="|AM/REBASE"
			fi
		elif [ -f "$g/MERGE_HEAD" ]; then
			r="|MERGING"
		elif __git_sequencer_status; then
			:
		elif [ -f "$g/BISECT_LOG" ]; then
			r="|BISECTING"
		fi

		if [ -n "$b" ]; then
			:
		elif [ -h "$g/HEAD" ]; then
			# symlink symbolic ref
			b="$(git symbolic-ref HEAD 2>/dev/null)"
		else
			local head=""
			if ! __git_eread "$g/HEAD" head; then
				return $exit
			fi
			# is it a symbolic ref?
			b="${head#ref: }"
			if [ "$head" = "$b" ]; then
				detached=yes
				b="$(
				case "${GIT_PS1_DESCRIBE_STYLE-}" in
				(contains)
					git describe --contains HEAD ;;
				(branch)
					git describe --contains --all HEAD ;;
				(tag)
					git describe --tags HEAD ;;
				(describe)
					git describe HEAD ;;
				(* | default)
					git describe --tags --exact-match HEAD ;;
				esac 2>/dev/null)" ||

				b="$short_sha..."
				b="($b)"
			fi
		fi
	fi

	if [ -n "$step" ] && [ -n "$total" ]; then
		r="$r $step/$total"
	fi

	local w=""
	local i=""
	local s=""
	local u=""
	local h=""
	local c=""
	local p=""

	if [ "true" = "$inside_gitdir" ]; then
		if [ "true" = "$bare_repo" ]; then
			c="BARE:"
		else
			b="GIT_DIR!"
		fi
	elif [ "true" = "$inside_worktree" ]; then
		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ] &&
		   [ "$(git config --bool bash.showDirtyState)" != "false" ]
		then
			git diff --no-ext-diff --quiet || w="*"
			git diff --no-ext-diff --cached --quiet || i="+"
			if [ -z "$short_sha" ] && [ -z "$i" ]; then
				i="#"
			fi
		fi
		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
		   git rev-parse --verify --quiet refs/stash >/dev/null
		then
			s="$"
		fi

		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
		   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
		   git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/null
		then
			u="%${ZSH_VERSION+%}"
		fi

		if [ -n "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
		   [ "$(git config --bool core.sparseCheckout)" = "true" ]; then
			h="?"
		fi

		if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
			__git_ps1_show_upstream
		fi
	fi

	local z="${GIT_PS1_STATESEPARATOR-" "}"

	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
			__git_ps1_colorize_gitstring
		fi
	fi

	b=${b##refs/heads/}
	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
		__git_ps1_branch_name=$b
		b="\${__git_ps1_branch_name}"
	fi

	local f="$h$w$i$s$u"
	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"

	if [ $pcmode = yes ]; then
		if [ "${__git_printf_supports_v-}" != yes ]; then
			gitstring=$(printf -- "$printf_format" "$gitstring")
		else
			printf -v gitstring -- "$printf_format" "$gitstring"
		fi
		PS1="$ps1pc_start$gitstring$ps1pc_end"
	else
		printf -- "$printf_format" "$gitstring"
	fi

	return $exit
}

################################ CMD PROMPT #############################

export PS1w=$'\033[35m'
export PS1u=$'\033[33m'
export PS1a=$'\033[38;2;100;100;100m'
export PS1c=$'\033[38;2;110;110;110m'
export PS1h=$'\033[34m'
export PS1p=$PS1u
export PS1P=$'\033[31m'
export PS1U=$PS1P

if [[ $EUID == 0 ]]; then
  export PS1='\[${PS1P}\]\u\[${PS1c}\]@\[${PS1h}\]\h\[${PS1c}\]:\[${PS1w}\]\W$(__git_ps1 "\[${PS1c}\](\[${gruv_purple}\]%s\[${PS1c}\])")\[$PS1P\]#\[\033[00m\] '
else
  export PS1='\[${PS1u}\]\u\[${PS1c}\]@\[${PS1h}\]\h\[${PS1c}\]:\[${PS1w}\]\W$(__git_ps1 "\[${PS1c}\](\[${gruv_purple}\]%s\[${PS1c}\])")\[$PS1p\]$\[\033[00m\] '
fi

ps1min () {
  export PS1='\[$gruv_orange\]$\[\033[00m\] '
}

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

## if gh-cli auto complete should not work:
## deactivate gh completion
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
#theme gruvbox-original-dark-medium

############################ FOREGROUND-COLORS ############################

export black=$'\033[30m'
export red=$'\033[31m'
export green=$'\033[32m'
export yellow=$'\033[33m'
export blue=$'\033[34m'
export magenta=$'\033[35m'
export cyan=$'\033[36m'
export white=$'\033[37m'

########################## Terminal ANSI Escapes ########################

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

############################## MANPAGES COLORS ##########################

export LESS_TERMCAP_mb=$magenta
export LESS_TERMCAP_md=$yellow
export LESS_TERMCAP_me=$reset
export LESS_TERMCAP_se=$reset
export LESS_TERMCAP_so=$blue
export LESS_TERMCAP_ue=$reset
export LESS_TERMCAP_us=$underline

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
alias c="printf  $'\033[2J\033[;H'" # clear
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

alias du='dust'
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
alias gview='git log --graph --full-history --all --pretty=format:"%h%x09%d%x20%s" --simplify-by-decoration'
alias gbigfiles='git rev-list --all | xargs -rL1 git ls-tree -r --long | sort -uk3 | sort -rnk4 | less'
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

################################# ARCH ##################################

cleanup() {
  sudo pacman -Rsn $(pacman -Qdtq) # removes orphant packages
  sudo pacman -Sc # removes all uninstalled packages from cache
}

paclog() { tail -n"$1" /var/log/pacman.log ;} # check the log

## list all installed AUR packages
# pacman -Qtm

##################################### EMOJI #############################

## emoji array
emojis=(🤖 👾 🤮 🤑 🤡 💩 👽 🥳 🤩 🤣 🤔 🖖 🙏 🧘 🛹 🛶 🥊 🎿 🎸  🤹  🐶 🐹 🐰 🦊 🐻 🐼 🐨 🐯 🦁
🐷 🐸 🐔 🐧 🐄 🦘 🦭     🦊 🐻  🦦 🦥 🦩 🐋 🐬 🐡 🐝 🌱 🦀 🦙 🦒 🐑 🐣 🦖 🦬    🦨 🐉 🦤    🐁 🦫    🐙 🦑 🐞 🪰    🐛 🦄 🐍 🐢 🐇 🦧 🦓 🦣   🌈   🥑 🥦 🍎 🥝 🍍 🍣)

emoji() {
  grabEmoji=${emojis[$RANDOM % ${#emojis[@]}]};
  echo $grabEmoji;
}
