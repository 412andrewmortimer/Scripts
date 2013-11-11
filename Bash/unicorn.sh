#!/bin/sh
#
# init.d script for single or multiple unicorn installations. Expects at least one .conf 
# file in /etc/unicorn
#
# Modified by jay@gooby.org http://github.com/jaygooby
# based on http://gist.github.com/308216 by http://github.com/mguterl
#
## A sample /etc/unicorn/my_app.conf
## 
## RAILS_ENV=production
## RAILS_ROOT=/var/apps/www/my_app/current
#
# This configures a unicorn master for your app at /var/apps/www/my_app/current running in
# production mode. It will read config/unicorn.rb for further set up. 
#
# You should ensure different ports or sockets are set in each config/unicorn.rb if
# you are running more than one master concurrently.
#
# If you call this script without any config parameters, it will attempt to run the
# init command for all your unicorn configurations listed in /etc/unicorn/*.conf
#
# /etc/init.d/unicorn start # starts all unicorns
#
# If you specify a particular config, it will only operate on that one
#
# /etc/init.d/unicorn start /etc/unicorn/my_app.conf
set -e
# Example init script, this can be used with nginx, too,
# since nginx and unicorn accept the same signals
 
# Feel free to change any of the following variables for your app:
TIMEOUT=${TIMEOUT-60}
APP_ROOT=/home/deploy/nginx/current
PID=/tmp/unicorn.pid
CMD="cd $APP_ROOT && bundle exec unicorn_rails -c $APP_ROOT/config/unicorn.rb -E staging -D"
USER=deploy
action="$1"
set -u
 
old_pid="$PID.oldbin"
 
cd $APP_ROOT || exit 1
 
sig () {
  test -s "$PID" && kill -$1 `cat $PID`
}
 
oldsig () {
  test -s $old_pid && kill -$1 `cat $old_pid`
}
 
workersig () {
	workerpid="/tmp/unicorn.$2.pid"
  test -s "$workerpid" && kill -$1 `cat $workerpid`
}
 
case $action in
start)
  sig 0 && echo >&2 "Already running" && exit 0
  su - $USER -c "$CMD"
  ;;
stop)
  sig QUIT && exit 0
  echo >&2 "Not running"
  ;;
force-stop)
  sig TERM && exit 0
  echo >&2 "Not running"
  ;;
restart|reload)
  sig HUP && echo reloaded OK && exit 0
  echo >&2 "Couldn't reload, starting '$CMD' instead"
  su - $USER -c "$CMD"
  ;;
upgrade)
  if sig USR2 && sleep 20 && sig 0 && oldsig QUIT
  then
    n=$TIMEOUT
    while test -s $old_pid && test $n -ge 0
    do
      printf '.' && sleep 1 && n=$(( $n - 1 ))
    done
    echo
 
    if test $n -lt 0 && test -s $old_pid
    then
      echo >&2 "$old_pid still exists after $TIMEOUT seconds"
      exit 1
    fi
    exit 0
  fi
  echo >&2 "Couldn't upgrade, starting '$CMD' instead"
  su - $USER -c "$CMD"
  ;;
kill_worker)
  workersig QUIT $2 && exit 0
  echo >&2 "Worker not running"
  ;;
 
reopen-logs)
  sig USR1
  ;;
*)
  echo >&2 "Usage: $0 <start|stop|restart|upgrade|force-stop|reopen-logs>"
  exit 1
  ;;
esac