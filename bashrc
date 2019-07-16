# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias sos='source ~/.bashrc'
alias ls='ls --color'
alias ll='ls -lh --time-style="+%Y-%m-%d %a %H:%M:%S"'
alias la='ll -a'
alias grep='grep --color'
alias grepx="grep -Rn --include=*.{c*,h*,lua,go} --exclude=*.{svn*,swp,tmp,pb.*,*~} "
alias grepa="grep -Rn "
alias findx="find . -name "
alias cl='make -j8 > /dev/null'
alias clmy='make -j8 -f Makefile.my'
alias mc='make clean'
alias ct='ctags -R .'
alias svnst='svn st|grep -v "^? "|grep -v "^X "'
alias svndif='svn diff > tmp; vi tmp'
alias svnup='cd ~/$TRUNK_CODE;svn up;cd -'
alias rmsvn='for i in `findx ".svn"`; do rm -rf $i; done'
alias duall='du -h --max-depth=1'
