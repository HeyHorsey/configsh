#!/bin/bash

t=`tty`
tt=`echo $t | sed -En "s/\/dev\///p"`
res=`who | grep $tt | sed -En "s/^.*(\(.*\)).*$/\1/p"`
#curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="$res PROJ VERSION stopping" --proxy1.0 cache.solvo.ru:3128 &> /dev/null
#/etc/init.d/dms-AET-gf stop
/etc/init.d/dms-AET-pf stop
#/etc/init.d/dms-AET-xml stop
/etc/init.d/dms-AET stop
#curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="$res PROJ VERSION stopped" --proxy1.0 cache.solvo.ru:3128 &> /dev/null
