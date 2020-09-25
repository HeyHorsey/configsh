#!/bin/bash

t=`tty`
tt=`echo $t | sed -En "s/\/dev\///p"`
res=`who | grep $tt | sed -En "s/^.*(\(.*\)).*$/\1/p"`
#curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="$res PROJ VERSION stopping" &> /dev/null
#/etc/init.d/dms-PROJ-gf stop
/etc/init.d/dms-PROJ-pf stop
#/etc/init.d/dms-PROJ-xml stop
/etc/init.d/dms-PROJ stop
#curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="$res PROJ VERSION stopped" &> /dev/null
