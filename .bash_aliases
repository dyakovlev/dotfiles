# less typing = more better

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias c='clear'
alias m='make'
alias v='vim'
alias g='git'

# editing things faster
alias ev='vim ~/.vimrc'
alias eb='vim ~/.bash_aliases'
alias r='source ~/.bash_profile'
#
# regen tags for all python source files
alias tags="/usr/bin/ctags -L <(find . -name '*.py') --fields=+iaS --sort=yes --extra=+q"

# git fuckery
alias st='git status'
alias co='git checkout'
alias br='git branch'

alias cb='git branch -D' # cleanup branch

alias ci='git commit -a -m'
alias ca='git commit --amend -a'

alias l='git log origin/master..' # log for this entire branch
alias d='git diff origin/master..' # diff for this entire branch
alias dc='git diff HEAD'
alias fc='git diff --name-status origin/master..' # list of files changed in the branch since the beginning
alias what='git whatchanged --oneline'

alias pto='git push origin HEAD -f'

alias wtf="fc | awk '\$1 !~ /D/ { print \$2 }' | xargs pyflakes"
alias unfuck='git clean -xfd && make clean && make'
alias ol="egrep '^class|def.*:\$'"
alias sc="sort | uniq -c | sort -rn"

# minor ls adjustments (this doesn't work with OSX ls)
alias la='ls -laG'
alias ll='ls -lG'

# color status
function cfc {
	echo -e '\E[1;32m' # green
	fc | grep '^A'
	echo -e '\E[1;33m' # yellow
	fc | grep '^M'
	echo -e '\E[0;31m' # red
	fc | grep '^D'
	echo -e '\E[1;34m' # light blue for wtf
	fc | grep -v '^[ADM]'
	tput sgr0
}

# who wrote, commit owner count
function ww {
  git blame -p $1 | sed -ne "s/^author //p" | sort | uniq -c | sort -rn
}

