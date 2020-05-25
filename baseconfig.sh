#!/bin/sh
# This is a basic setup script for Solvo environment


# Project section

echo 'Enter project username:'
read PROJUSER
echo 'Enter system version'
read SYSVERSION
echo 'Enter system repo name:'
read PROJREPO
echo 'If planning to send logs via Telegram enter chat id (leave blank if not needed):'
read CHATID
if [ -n $CHATID ]; then
  echo 'Enter bot token:'
  read BOTTOKEN
  echo 'Enter Telegram proxy address if needed (leave blank if not):'
  read PROXY
fi

# root section

## scripts setup

cp scripts/start.sh ~/$PROJUSER'_start.sh'
cp scripts/stop.sh ~/$PROJUSER'_stop.sh'
cp scripts/update.sh ~/$PROJUSER'_update.sh'
PROJDIR=$(sudo -i -u $PROJUSER pwd)
cp scripts/payaradeploy $PROJDIR/bin/
chmod +x ~/$PROJUSER'_start.sh'
chmod +x ~/$PROJUSER'_stop.sh'
chmod +x ~/$PROJUSER'_update.sh'
sed -i "s/PROJ/$PROJUSER/g"  ~/$PROJUSER'_start.sh'
sed -i "s/PROJ/$PROJUSER/g"  ~/$PROJUSER'_stop.sh'
sed -i "s/PROJ/$PROJUSER/g"  ~/$PROJUSER'_update.sh'
sed -i "s/TOSREPO/$PROJREPO/g"  ~/$PROJUSER'_update.sh'
if [ -n $CHATID ]; then
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
  sed -i "s/PROJ/$PROJUSER/g" $PROJDIR/bin/payaradeploy
  sed -i "s/\#curl/curl/g" $PROJDIR/bin/payaradeploy
  sed -i "s/CHATID/$CHATID/g"  $PROJDIR/bin/payaradeploy
  sed -i "s/TOKEN/$BOTTOKEN/g"  $PROJDIR/bin/payaradeploy
  sed -i "s/VERSION/$SYSVERSION/g" $PROJDIR/bin/payaradeploy
  if [ -n $PROXY ]; then
    sed -i "s/PROXY/--proxy1.0 $PROXY/g" ~/$PROJUSER'_start.sh'
    sed -i "s/PROXY/--proxy1.0 $PROXY/g" ~/$PROJUSER'_stop.sh'
    sed -i "s/PROXY/--proxy1.0 $PROXY/g" ~/$PROJUSER'_update.sh'
    sed -i "s/PROXY/--proxy1.0 $PROXY/g" $PROJDIR/bin/payaradeploy
  else
    sed -i "s/PROXY/ /g" ~/$PROJUSER'_start.sh'
    sed -i "s/PROXY/ /g" ~/$PROJUSER'_stop.sh'
    sed -i "s/PROXY/ /g" ~/$PROJUSER'_update.sh'
    sed -i "s/PROXY/ /g" $PROJDIR/bin/payaradeploy
  fi
fi
chmod +x $PROJDIR/bin/payaradeploy
chown $PROJUSER $PROJDIR/bin/payaradeploy

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

# Finished
echo 'Done, please review scripts'