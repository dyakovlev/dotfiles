# less typing = more better

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias irc='screen -r irc'

alias c='clear'
alias m='make'
alias v='nvim'
alias g='git'
alias b='bundle exec'

# editing things faster
alias ev='v ~/.config/nvim/init.vim'
alias eb='v ~/.bash_aliases'
alias r='source ~/.bash_profile && hash -r'

# git fuckery
alias st='git status'
alias co='git checkout'
alias br='git branch'
alias mb='git co -b'

alias fo='git fetch origin'
alias rom='fo && git rebase origin/master'
alias ir='git rebase -i origin/master'
alias msk='git ci -am "squash me" && ir'

alias cb='git branch -D'
alias cbr='git push origin --delete'

alias ci='git commit -a -m'
alias ca='git commit --amend -a'

alias gg='git grep --color=always --break --heading'

alias l='git log origin/master..' # log for this entire branch
alias d='git diff origin/master..' # diff for this entire branch
alias dc='git diff HEAD'
alias fc='git diff --name-status origin/master..' # list of files changed in the branch since the beginning
alias what='git whatchanged --oneline origin/master..'

alias pto='git push origin HEAD -f'

alias sc="sort | uniq -c | sort -rn"

# minor ls adjustments (this doesn't work with OSX ls)
alias la='ls -laG'
alias ll='ls -lG'
