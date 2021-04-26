
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
