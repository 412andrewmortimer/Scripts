###############
#   rbenv    #
#############

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


####################
# git completion  #
##################

source ~/.git_completion.sh

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

function parse_ruby_version {
  ruby -v | cut -d" " -f2
}

function parse_github_user {
  git config --get remote.origin.url | sed 's/^.*:\([^/]*\)\/.*\.git/(\1)/'
}
###########################
# terminal customization #
#########################


 PS1='⦗$(parse_ruby_version)⦘$(__git_ps1 "⦗\[\e[0;32m\]%s\[\e[0m\]\[\e[0;33m\]$(parse_git_dirty)\[\e[0m\]⦘")⦗\W⦘☉ '
 
 git config --global color.ui true
# a="\n\[\033[38m\]\u\[\033[01;34m\] \w \[\033[31m\]"
# b="\`ruby -e \"print RUBY_VERSION\"\`"
# d="\`ruby -e \"print (%x{git branch --no-color 2> /dev/null}.split(%r{\n}).grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1)')\"\`\[\033[37m\]\n"
# e="$\[\033[00m\] "
# PS1="$a$b$d$e"


# a="☉ [$(parse_ruby_version)] ☉ "
# b="$(__git_ps1 "[\[\e[0;32m\]%s\[\e[0m\]\[\e[0;33m\]$(parse_git_dirty)\[\e[0m\]] ☉ ")"
# c="[\u➤ \W] ☉ \n"
# d="\$"
# PS1="$a$b$c$d"

#####################
# Directory Colors #
###################

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

################
#   iTerm2    #
##############

export HISTCONTROL=ignoreboth
shopt -s histappend
# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

############
# Aliases #
##########

# System
alias ll='ls -la'
alias la='ls -a'
alias l='ls'
alias ..='cd ..'
alias subl='sublime'
alias fr='rm -fr'
alias rbp='source ~/.bash_profile'
alias home="cd ~; clear;"

# Ruby
alias r="ruby"
alias i="pry --simple-prompt"
alias rk="rake"
alias rkt="rake -T"
alias b="bundle"
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"

#Ruby on Rails
alias ber='bundle exec rake'
alias be='bundle exec'

#    console
alias rlc="pry --simple-prompt -r ./config/environment"

#    server
function rls() {
  if [ -x script/rails ]; then
    script/rails server thin $@
  else
    script/server $@
  fi
}

#    generator
function rlg() {
  if [ -x script/rails ]; then
    script/rails generate $@
  else
    script/generate $@
  fi
}

#    other
alias rkdm="rake db:migrate"
alias rkdmr="rake db:migrate:redo"
alias rkdr="rake db:rollback"
alias rkdc="rake db:create"
alias rklc="rake log:clear"
alias rkr="rake routes"
alias testdb="RAILS_ENV=test ber db:drop && RAILS_ENV=test ber db:create && RAILS_ENV=test ber db:schema:load"

#Search
alias hg='history | grep'
alias fns='find . | ack'
alias lwp='find `pwd` -name "*.*"'

# Git
alias g="git status"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit -m"
alias gb="git branch"
alias gba="git branch -a"
alias gbd="git branch -d"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcot="git checkout -t"
alias gf="git fetch"
alias gm="git merge"
alias gmn="git merge --no-ff"
alias gr="git rebase"
alias gri="git rebase -i"
alias griu="git rebase -i @{upstream}"
alias gl="git log"
alias glr=" git --no-pager log --graph --abbrev-commit --date=relative -10 --all --pretty='tformat:%C(yellow)%h%Creset -%C(red)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias gs="git show"
alias gd="git diff"
alias gbl="git blame"
alias gps="git push"
alias gpsd="git push --delete"
alias gpso="git push -u origin"
alias gpsdo="git push --delete origin"
alias gpl="git pull"



# Vagrant
alias vagrantd='ssh deploy@127.0.0.1 -p 2222'

# Browser
alias chrome='open -a Google\ Chrome'

#    explain shell
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

#    github
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
##############
# OS X Only #
############
alias dock2d='defaults write com.apple.dock no-glass -boolean YES; killall Dock'
alias dock3d='defaults write com.apple.dock no-glass -boolean NO; killall Dock'
alias lame='ssh-add ~/.ssh/id_rsa && mysql.server start'
