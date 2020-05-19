#!/bin/bash

t=`tty`
tt=`echo $t | sed -En "s/\/dev\///p"`
res=`who | grep $tt | sed -En "s/^.*(\(.*\)).*$/\1/p"`
#curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="$res PROJ VERSION starting" PROXY &> /dev/null
/etc/init.d/dms-PROJ start
#/etc/init.d/dms-PROJ-xml start
#/etc/init.d/dms-PROJ-gf start
sleep 60
/etc/init.d/dms-PROJ-pf start
#curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="$res PROJ VERSION started" PROXY &> /dev/null
