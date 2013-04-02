#############
# rbenv     #
#############

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

###################
# Git Completion  #
###################

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
########################
# COMMAND PROMPT CUZTO #
########################

# PS1='☉ [$(parse_ruby_version)] ☉ $(__git_ps1 "[\[\e[0;32m\]%s\[\e[0m\]\[\e[0;33m\]$(parse_git_dirty)\[\e[0m\]] ☉ ") [\u➤ \W] ☉ \n \$ '

# a="\n\[\033[38m\]\u\[\033[01;34m\] \w \[\033[31m\]"
# b="\`ruby -e \"print RUBY_VERSION\"\`"
# d="\`ruby -e \"print (%x{git branch --no-color 2> /dev/null}.split(%r{\n}).grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1)')\"\`\[\033[37m\]\n"
# e="$\[\033[00m\] "
# PS1="$a$b$d$e"


a="☉ [$(parse_ruby_version)] ☉ "
b="$(__git_ps1 "[\[\e[0;32m\]%s\[\e[0m\]\[\e[0;33m\]$(parse_git_dirty)\[\e[0m\]] ☉ ")"
c="[\u➤ \W] ☉ \n"
d="\$"
PS1="$a$b$c$d"

##############
# Dir Colors #
##############

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

###############


###############
# Aliases #####
###############

alias ll='ls -la'
alias la='ls -a'
alias l='ls'
alias ..='cd ..'
alias subl='sublime'
