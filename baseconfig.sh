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

cp scripts/start.sh ~/$PROJUSER'_start.sh'
cp scripts/stop.sh ~/$PROJUSER'_stop.sh'
cp scripts/update.sh ~/$PROJUSER'_update.sh'
PROJDIR=$(sudo -i -u $PROJUSER pwd)
cp scripts/payaradeploy $PROJDIR/bin/
cp scripts/versions.sh $PROJDIR/bin/versions
cp scripts/postinstall $PROJDIR/bin/

chmod +x ~/$PROJUSER'_start.sh'
chmod +x ~/$PROJUSER'_stop.sh'
chmod +x ~/$PROJUSER'_update.sh'

sed -i "s/PROJ/$PROJUSER/g"  ~/$PROJUSER'_start.sh'
sed -i "s/PROJ/$PROJUSER/g"  ~/$PROJUSER'_stop.sh'
sed -i "s/PROJ/$PROJUSER/g"  ~/$PROJUSER'_update.sh'
sed -i "s/TOSREPO/$PROJREPO/g"  ~/$PROJUSER'_update.sh'

sed -i "s/PROJ/$PROJUSER/g" $PROJDIR/bin/payaradeploy
chmod +x $PROJDIR/bin/payaradeploy
chown $PROJUSER $PROJDIR/bin/payaradeploy

sed -i "s/PROJ/$PROJUSER/g" $PROJDIR/bin/versions
chmod +x $PROJDIR/bin/versions
chown $PROJUSER $PROJDIR/bin/versions

sed -i "s/PROJ/$PROJUSER/g" $PROJDIR/bin/postinstall
chmod +x $PROJDIR/bin/postinstall
chown $PROJUSER $PROJDIR/bin/postinstall

if ! [ -z "$CHATID" ]; then
  sed -i "s/\#curl/curl/g" ~/$PROJUSER'_start.sh'
  sed -i "s/CHATID/$CHATID/g"  ~/$PROJUSER'_start.sh'
  sed -i "s/TOKEN/$BOTTOKEN/g"  ~/$PROJUSER'_start.sh'
  sed -i "s/VERSION/$SYSVERSION/g" ~/$PROJUSER'_start.sh'
  sed -i "s/\#curl/curl/g" ~/$PROJUSER'_stop.sh'
  sed -i "s/CHATID/$CHATID/g"  ~/$PROJUSER'_stop.sh'
  sed -i "s/TOKEN/$BOTTOKEN/g"  ~/$PROJUSER'_stop.sh'
  sed -i "s/VERSION/$SYSVERSION/g" ~/$PROJUSER'_stop.sh'
  sed -i "s/\#curl/curl/g" ~/$PROJUSER'_update.sh'
  sed -i "s/CHATID/$CHATID/g"  ~/$PROJUSER'_update.sh'
  sed -i "s/TOKEN/$BOTTOKEN/g"  ~/$PROJUSER'_update.sh'
  sed -i "s/VERSION/$SYSVERSION/g" ~/$PROJUSER'_update.sh'
  sed -i "s/\#curl/curl/g" $PROJDIR/bin/payaradeploy
  sed -i "s/CHATID/$CHATID/g"  $PROJDIR/bin/payaradeploy
  sed -i "s/TOKEN/$BOTTOKEN/g"  $PROJDIR/bin/payaradeploy
  sed -i "s/VERSION/$SYSVERSION/g" $PROJDIR/bin/payaradeploy
  sed -i "s/\#curl/curl/g" $PROJDIR/bin/postinstall
  sed -i "s/CHATID/$CHATID/g"  $PROJDIR/bin/postinstall
  sed -i "s/TOKEN/$BOTTOKEN/g"  $PROJDIR/bin/postinstall
  sed -i "s/VERSION/$SYSVERSION/g" $PROJDIR/bin/postinstall
fi


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