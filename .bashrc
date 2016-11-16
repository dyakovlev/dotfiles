# runs for non-login shells

if [ -d ~/bin ] ; then
	export PATH=~/bin:"${PATH}"
fi

if [ -d ~/man ] ; then
	export MANPATH=~/man:"${MANPATH}"
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

__git_ps1 ()
{
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
       printf " (%s)" "${b##refs/heads/}";
    fi
}

export PS1='\
\[\e[01;30m\]\t \
\[\e[01;37m\][\
`[ $UID == 0 -a $USER != $(logname) ]\
&& echo "\[\e[00;31m\]"`\
`[ $UID == 0 -a $USER != $(logname) -a -z "$SUDO_USER" ]\
&& echo "\[\e[01;31m\]"`\
`[ $UID == 0 -a $USER == $(logname) ]\
&& echo "\[\e[01;33m\]"`\
`[ $UID != 0 -a $USER == $(logname) ]\
&& echo "\[\e[00;32m\]"`\
`[ $UID != 0 -a $USER != $(logname) ]\
&& echo "\[\e[00;33m\]"`\
\u\
\[\e[00;36m\]@\
`[ "$SSH_CLIENT" != "" -o "$SSH2_CLIENT" != "" ]\
&& echo "\[\e[00;33m\]"\
|| echo "\[\e[00;32m\]"`\
\h \
`[ -w "${PWD}" ]\
&& echo "\[\e[01;34m\]\W"\
|| echo "\[\e[01;31m\]\W"`\
\[\e[01;37m\]]\
`[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]]\
&& echo "\[\e[01;31m\]"\
|| echo "\[\e[01;32m\]"`$(__git_ps1 "(%s)")\[\e[00m\]\$ '

export PATH=$PATH:~/node/bin

export EDITOR VISUAL GIT_EDITOR
EDITOR=vim
VISUAL=$EDITOR
GIT_EDITOR=$EDITOR
