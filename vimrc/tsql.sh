#! /bin/bash
# an example wrapper script to start mysql using visql.vim as inner $EDITER
# `visql` is a soft link name of `vim` which will load `visql.vim` as vimrc
# or directlly set:
# export EDITOR=`vim -u path/to/vimsql.vim`

export LOGDIR=$HOME/mysql
export EDITOR=visql
export MYSQL_DBDICT=$LOGDIR/utrade.dic

# visql can also make use of these connection information to preview table
export MYSQL_FLAG=-A\ --default-character-set=utf8
export MYSQL_PROG=mysql
export MYSQL_HOST=192.168.1.111
# export MYSQL_PORT
export MYSQL_USER=user
export MYSQL_PASS=passwd
export MYSQL_DATABASE=dbname

# --tee=$LOGFILE is not necessary
cd $LOGDIR
today=$(date +%Y%m%d)
LOGFILE=tee.log.$today

exec mysql -u $MYSQL_USER -p$MYSQL_PASS -h $MYSQL_HOST --tee=$LOGFILE $MYSQL_FLAG $MYSQL_DATABASE "$@"
