# runs for non-login shells

if [ -d ~/bin ] ; then
	export PATH=~/bin:"${PATH}"
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

function parse_git_branch {
  ref=$(git-symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}

PS1="\u@\h:\w \$(parse_git_branch)\$ "

export PATH=$PATH:~/node/bin

export EDITOR VISUAL GIT_EDITOR
EDITOR=vim
VISUAL=$EDITOR
GIT_EDITOR=$EDITOR
