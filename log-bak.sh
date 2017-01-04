#!/bin/bash

ip_addr=
bak_addr=
log_mod=
logs_dir=/data/logs/www/
bak_dir=/data/logs/logsbak
nginx_app=/usr/local/nginx/sbin/nginx
[ -d $bak_dir ] || mkdir $bak_dir
date=`date -d "yesterday" +%Y%m%d`
old_date=`date -d "5 days ago" +%Y%m%d`
mkdir $bak_dir/$date
cd $logs_dir
mv *.log $bak_dir/$date
#sleep 3
$nginx_app -s reload
cd $bak_dir
tar czf $date.$ip_addr.tgz $date && rm -rf $date
rm -f $old_date.$ip_addr.tgz
/usr/bin/rsync -av --port=874 --password-file=/etc/rsyncd-logbak.pwd $bak_dir/ log@$bak_addr::$log_mod
