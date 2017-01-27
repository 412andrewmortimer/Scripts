###################
# git completion #
#################
source ~/.git_completion.sh

###########################
# terminal customization #
#########################
function parse_ruby_version {
  ruby -v | cut -d" " -f2
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

function parse_github_user {
  git config --get remote.origin.url | sed 's/^.*:\([^/]*\)\/.*\.git/(\1)/'
}

PS1='\[\e[1;34m\]⦗$(parse_ruby_version)⦘\[\e[m\]$(__git_ps1 "\[\e[1;35m\]⦗%s⦘\[\e[0m\]")\[\e[1;34m\]⦗\W⦘\[\e[m\]\[\e[1;32m\]➤\[\e[m\] '


############
# aliases #
##########

# system
alias ll='ls -la'
alias la='ls -a'
alias l='ls'
alias tree="tree -C"
alias ..='cd ..'
alias ...='cd ../..'
alias fr='rm -fr'
alias home="cd ~; clear;"


# ruby
alias b="bundle"
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias ber='bundle exec rake'

# ruby on rails
alias bers="bundle exec rails server"


#  console
alias rlc="pry --simple-prompt -r ./config/environment"

###########
# search #
#########
alias hg='history | grep'
alias fns='find . | ack'
alias lwp='find `pwd` -name "*.*"'

########
# git #
######
alias g="git status"
alias gr="git reset --hard HEAD"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit -m"
alias gb="git branch"
alias gba="git branch -a"
alias gbd="git branch -d"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gf="git fetch"
alias gl="git log"
alias glr=" git --no-pager log --graph --abbrev-commit --date=relative -10 --all --pretty='tformat:%C(yellow)%h%Creset -%C(red)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glrr="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias glp="git log --pretty=oneline --abbrev-commit"
alias gpl="git pull"

function gloc {
  git ls-files | xargs wc -l
}

#########
# misc #
#######
alias md5="openssl passwd -1"
alias pw="openssl passwd -crypt"
