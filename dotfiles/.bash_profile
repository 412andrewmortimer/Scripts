#########
# PATH #
#######
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:~/bin
export PATH=$PATH:/usr/local/packer
export PATH="/usr/local/heroku/bin:$PATH"

##########
# rbenv #
########
eval "$(rbenv init -)"

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
git config --global color.ui true

#####################
# directory colors #
###################
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

###########
# iTerm2 #
#########
export HISTCONTROL=ignoreboth
shopt -s histappend
# after each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

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
alias rbp='source ~/.bash_profile'
alias bpe="subl ~/.bash_profile"
alias home="cd ~; clear;"
alias w="cd ~/ww_rcms"
alias ww="cd ~/wtw_cms_beta"
# ruby

alias b="bundle"
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
alias ber='bundle exec rake'

# ruby on rails
alias clean="bundle exec rake db:drop && bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rake db:seed"
alias bers="bundle exec rails server"
alias berts="RAILS_ENV=test bundle exec rails server -p 4242"
alias stag="cat config/deploy/staging.rb"
alias prod="cat config/deploy/production.rb"
#  console
alias rlc="pry --simple-prompt -r ./config/environment"
#  server
function rls() {
  if [ -x script/rails ]; then
    script/rails server thin $@
  else
    script/server $@
  fi
}

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

############
# vagrant #
##########
alias vagrantd='ssh deploy@127.0.0.1 -p 2222'
alias avk='ssh-add ~/.vagrant.d/insecure_private_key'

############
# browser #
##########

# chrome
alias chrome='open -a Google\ Chrome'

# explain shell
function explain {
  # base url with first command already injected
  # $ explain tar
  #   => http://explainshel.com/explain/tar?args=
  url="http://explainshell.com/explain/$1?args="

  # removes $1 (tar) from arguments ($@)
  shift;

  # iterates over remaining args and adds builds the rest of the url
  for i in "$@"; do
    url=$url"$i""+"
  done

  # opens url in browser
  open $url
}

# github
function gh {
  url="https://github.com/WalltoWall/$1"
  chrome $url
}

function ghc {
  current_repo=`basename $PWD`
  url="https://github.com/WalltoWall/$current_repo"
  chrome $url
}

function ghci {
  current_repo=`basename $PWD`
  url="https://github.com/WalltoWall/$current_repo/issues"
  chrome $url
}

########
# ssh #
######
alias rmk='ssh-keygen -R'
alias ssa='ssh-add ~/.ssh/id_rsa.pub'
alias pup='ssh devops@puppet.walltowall.com'

#########
# misc #
#######
alias md5="openssl passwd -1"
alias pw="openssl passwd -crypt"

##############
# os x only #
############
alias lame='ssh-add ~/.ssh/id_rsa && mysql.server start'

