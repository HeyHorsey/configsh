#!/bin/sh
# This is a basic setup script for Solvo environment


# Project section

echo 'Enter project username:'
read PROJUSER

# root section

yum install -y mc vim htop
cd
echo -e "\nHISTTIMEFORMAT='%F %T > '" >> .bashrc

if yum install -y rlwrap; then
  su -l $PROJUSER -c 'printf "alias sqlplus=\"rlwrap sqlplus\"" ; exit'
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