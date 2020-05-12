#!/bin/sh
# This is a basic setup script for Solvo environment


# Project section

echo 'Enter project username:'
read PROJUSER
echo 'Enter system version'
read SYSVERSION
echo 'Если планируется автоматическое логгирование действий в Телеграм — введите id чата (если нет — оставьте поле пустым):'
read CHATID
if [ -n $CHATID ]; then
  echo 'Введите токен бота:'
  read BOTTOKEN
  echo 'Введите адрес прокси-сервера'
  read PROXY
fi

# root section

## scripts setup

cp scripts/start.sh ~/$PROJUSER'_start.sh'
cp scripts/stop.sh ~/$PROJUSER'_stop.sh'
#cp scripts/update.sh ~/$PROJUSER'_update.sh'
sed -i "s/PROJ/$PROJUSER/g"  ~/$PROJUSER'_start.sh'
sed -i "s/PROJ/$PROJUSER/g"  ~/$PROJUSER'_stop.sh'
if [ -n $CHATID ]; then
  sed -i "s/\#curl/curl/g" ~/$PROJUSER'_start.sh'
  sed -i "s/CHATID/$CHATID/g"  ~/$PROJUSER'_start.sh'
  sed -i "s/TOKEN/$BOTTOKEN/g"  ~/$PROJUSER'_start.sh'
  sed -i "s/VERSION/$SYSVERSION/g" ~/$PROJUSER'_start.sh'
  sed -i "s/PROXY/$PROXY/g" ~/$PROJUSER'_start.sh'
  sed -i "s/\#curl/curl/g" ~/$PROJUSER'_stop.sh'
  sed -i "s/CHATID/$CHATID/g"  ~/$PROJUSER'_stop.sh'
  sed -i "s/TOKEN/$BOTTOKEN/g"  ~/$PROJUSER'_stop.sh'
  sed -i "s/VERSION/$SYSVERSION/g" ~/$PROJUSER'_stop.sh'
  sed -i "s/PROXY/$PROXY/g" ~/$PROJUSER'_stop.sh'
fi

## tuning

yum install -y mc vim htop sl
cd
echo -e "\nHISTTIMEFORMAT='%F %T > '" >> .bashrc

if yum install -y rlwrap; then
  su -l $PROJUSER -c 'printf "alias sqlplus=\"rlwrap sqlplus\"" >> .bashrc; exit'
else
  su -l $PROJUSER -c 'sed -i "s/alias sqlplus/\#alias sqlplus/g" .bashrc ; exit'
fi

# User section

echo 'Logging in as' %PROJUSER

su -l $PROJUSER -c '
echo -e "\nHISTTIMEFORMAT='%F %T > '" >> .bashrc
sed -i "s/ru_RU/en_US/g" .bashrc
cp bin/jsm_talman bin/jsm_talman_big
chmod +r bin/jsm_talman_big
sed -i "s/normal\-\*\-13\-\*\-75\-75\-c\-70/normal\-\-20\-200\-75\-75\-c\-100/g" bin/jsm_talman_big
exit '