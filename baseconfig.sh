#!/bin/sh
# This is a basic setup script for Solvo 7.x environment


# Project section

echo 'Enter project username:'
read PROJUSER
echo 'Enter system version'
read SYSVERSION  #no dots
echo 'Enter system repo name:'
read PROJREPO
echo 'If planning to send logs via Telegram enter chat id (leave blank if not needed):'
read CHATID
if ! [ -z "$CHATID" ]; then
  echo 'Enter bot token:'
  read BOTTOKEN
fi

# root section

## scripts setup

sed -i "s/PROJ/$PROJUSER/g"  scripts/*
sed -i "s/TOSREPO/$PROJREPO/g"  scripts/*
if ! [ -z "$CHATID" ]; then
  sed -i "s/\#curl/curl/g" scripts/*
  sed -i "s/CHATID/$CHATID/g"  scripts/*
  sed -i "s/TOKEN/$BOTTOKEN/g"  scripts/*
  sed -i "s/VERSION/$SYSVERSION/g" scripts/*
  sed -i "s/\#tg/tg/g" scripts/*
fi

## Root scripts move

cp scripts/start.sh ~/$PROJUSER'_start.sh'
cp scripts/stop.sh ~/$PROJUSER'_stop.sh'
cp scripts/update.sh ~/$PROJUSER'_update.sh'

chmod +x ~/$PROJUSER'_start.sh'
chmod +x ~/$PROJUSER'_stop.sh'
chmod +x ~/$PROJUSER'_update.sh'

## User scripts move

PROJDIR=$(sudo -i -u $PROJUSER pwd)

cp scripts/payaradeploy $PROJDIR/bin/
chmod +x $PROJDIR/bin/payaradeploy
chown $PROJUSER $PROJDIR/bin/payaradeploy

cp scripts/ucomplete $PROJDIR/bin/
chmod +x $PROJDIR/bin/ucomplete
chown $PROJUSER $PROJDIR/bin/ucomplete

cp scripts/versions.sh $PROJDIR/bin/versions
chmod +x $PROJDIR/bin/versions
chown $PROJUSER $PROJDIR/bin/versions

cp scripts/postinstall $PROJDIR/bin/
chmod +x $PROJDIR/bin/postinstall
chown $PROJUSER $PROJDIR/bin/postinstall

cp scripts/dbpatch $PROJDIR/bin/
chmod +x $PROJDIR/bin/dbpatch
chown $PROJUSER $PROJDIR/bin/dbpatch

cp scripts/tgmesg $PROJDIR/bin/
chmod +x $PROJDIR/bin/tgmesg
chown $PROJUSER $PROJDIR/bin/tgmesg

cp scripts/tgfile $PROJDIR/bin/
chmod +x $PROJDIR/bin/tgfile
chown $PROJUSER $PROJDIR/bin/tgfile

chmod +x $PROJDIR/bin/dblogin
chown $PROJUSER $PROJDIR/bin/dblogin

## tuning

yum install -y mc vim htop sl
cd
echo -e "\nHISTTIMEFORMAT='%F %T > '" >> .bashrc

if yum install -y rlwrap; then
  sudo -i -u $PROJUSER sh -c 'printf "alias sqlplus=\"rlwrap sqlplus\"" >> .bashrc; exit'
else
  sudo -i -u $PROJUSER sh -c 'sed -i "s/alias sqlplus/\#alias sqlplus/g" .bashrc ; exit'
fi

# User section

echo 'Logging in as' %PROJUSER

sudo -i -u $PROJUSER sh -c 'echo -e "\nHISTTIMEFORMAT=\"%F %T > \"" >> .bashrc'
sudo -i -u $PROJUSER sh -c 'sed -i "s/ru_RU/en_US/g" .bashrc'
sudo -i -u $PROJUSER sh -c 'cp bin/jsm_talman bin/jsm_talman_big'
sudo -i -u $PROJUSER sh -c 'chmod +x bin/jsm_talman_big'
sudo -i -u $PROJUSER sh -c 'sed -i "s/normal\-\*\-13\-\*\-75\-75\-c\-70/normal\-\-20\-200\-75\-75\-c\-100/g" bin/jsm_talman_big'
sudo -i -u $PROJUSER sh -c 'ln -s /usr/local/TOS/$PROJUSER/.local/share/Solvo/wtm/logs tmp/watch/wtm'
sudo -i -u $PROJUSER sh -c 'ln -s /usr/local/TOS/$PROJUSER/.local/share/Solvo/uvp/logs tmp/watch/uvp'

# Finished
echo 'Done, please review scripts'