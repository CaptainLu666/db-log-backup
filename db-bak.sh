#!/bin/bash

Pass=
Date=$(date +"%Y%m%d")
Date5d=$(date +"%Y%m%d" -d "5 days ago")
Date15d=$(date +"%Y%m%d" -d "14 days ago")
db_name=
mod_name=
ip_addr=
bak_addr=
[ ! -d /data/mysqlback ] && mkdir /data/mysqlback

/bin/rm -f /data/mysqlback/$db_name-$IPADDR-$Date15d.sql.gz
/usr/bin/mysqldump -uroot -p$Pass $db_name |gzip > /data/mysqlback/$db_name-$IPADDR-$Date.sql.gz
/usr/bin/rsync -av --port=875 --password-file=/etc/rsyncd-db.pwd /data/mysqlback/ db@$bak_addr::$mod_name/  &>/tmp/rsync-$db_name-bak.log
