# less typing = more better

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias c='clear'
alias m='make'
alias v='nvim'
alias g='git'
alias b='bonsai'
alias k='kubectl'

# editing things faster
alias ev='v ~/.config/nvim/init.vim'
alias eb='v ~/.bash_aliases'
alias r='source ~/.bash_profile && hash -r'

# git workflows
alias st='git status'
alias co='bonsai branch' # check out
alias br='bonsai branch' # branches (list)
alias mb='bonsai branch' # make branch

alias fo='git fetch origin'
# alias rom='fo && git rebase origin/master' # rebase discouraged by work infra
alias mm='fo && git merge origin/master'
alias ir='git rebase -i origin/master'
alias msk='git ci -am "squash me" && ir'

alias ci='git commit -a -m'
alias ca='git commit --amend -a'

# search over checked-in files
alias gg='git grep --color=always --break --heading'

# log of all commits on feature branch
alias l='git log origin/master..'

# diff of all commits on feature branch
alias d='git diff origin/master..'

# diff of all uncommitted changes in working directory
alias dc='git diff HEAD'

# list of commits with files changed in each one (two flavors)
alias fc='git log --raw --no-merges origin/master..'
alias what='git whatchanged --oneline origin/master..'

# count incidences of each unique line in stdin
alias sc="sort | uniq -c | sort -rn"

# minor ls adjustments (this doesn't work with OSX ls)
alias la='ls -laG'
alias ll='ls -lG'
