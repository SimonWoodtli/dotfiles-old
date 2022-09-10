
############################## CMD PROMPT ##############################

# Syntactic sugar for ANSI escape sequences
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset
#d=$'\033[38;2;110;110;110m'
#txtdark='\e[90m'

p='\e[0;35m' # Purple
c='\e[0;36m' # Cyan
b='\e[0;34m' # Blue
r='\e[0;31m' # Red
y='\e[0;33m' # Yellow
d='\e[38;2;110;110;110m' # Dark
r='\e[0m'    # Text Reset

__ps1() {
  #git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
  #git branch --show-current 2> /dev/null
  git symbolic-ref --short HEAD 2>/dev/null
  #[[ $B = master || $B = main ]] && b="$r"
}

##TODO change colors if root == red or normal user == yellow
##TODO get rid of () if not a git repo
##TODO change color if main branch == red

export PS1="\[$y\]\u\[$d\]@\[$b\]\h\[$d\]:\[$p\]\W\[$d\](\[$c\]\$(__ps1)\[$d\])\[$b\]\$\[$r\] "
##works
#export PS1="\[$y\]\u\[$d\]@\[$b\]\h\[$d\]:\[$p\]\W\[$d\](\[$c\]\$(__ps1)\[$d\])\[\033[00m\]\$ "

#PROMPT_COMMAND="__ps1"
