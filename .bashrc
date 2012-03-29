# runs for non-login shells

if [ -d ~/bin ] ; then
	export PATH=~/bin:"${PATH}"
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

export PATH=$PATH:~/node/bin

export EDITOR VISUAL GIT_EDITOR
EDITOR=vim
VISUAL=$EDITOR
GIT_EDITOR=$EDITOR
