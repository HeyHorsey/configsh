#!/bin/bash

# undeploy payara
su -l PROJ -c '
  websmc_payara_undeploy
  exit'

# stop env
cd
PROJ-stop.sh
pkill -f opt/solvo -u PROJ

# update system
if ! yum update -y --disblerepo=* --enablerepo=PROJREPO; then
  #curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="PROJ VERSION update failed, please proceed manually!" --proxy1.0 PROXY &> /dev/null
  echo  'PROJ VERSION update failed, please proceed manually!'
  exit 1
fi

# DB patch
# shellcheck disable=SC2016
su -l PROJ -c '
  cd ~/mdd/
  rm patch.sql
  make patch.sql
  rm patch.log
  rm patch.err.log
  make dbpatch | tee patch.log
  grep -5 ORA patch.log > patch.err.log
  #curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="Please see dbpatch errors for PROJ VERSION" PROXY &> /dev/null
  #curl -F document=@patch.err.log https://api.telegram.org/botTOKEN/sendDocument?chat_id=CHATID &> /dev/null
  echo "#####\n#####\n#####\n#####\n####"
  cd
  post_install_sql &> ~/post_install_sql.log
  grep -5 ORA ~/post_install_sql.log > post_install_sql.err.log
  #curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="Please see post_install errors for PROJ VERSION" PROXY &> /dev/null
  #curl -F document=@post_install_sql.err.log https://api.telegram.org/botTOKEN/sendDocument?chat_id=CHATID &> /dev/null
  #sqlplus -S $DB_USER/$DB_PASSWD@$DB_NAME @ /sql__ee/catalog.sql
  exit
  '

# System start
PROJ-start.sh

# Deploy payara
su -l PROJ -c '
  if ! websmc_payara_deploy; then
    #curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="PROJ VERSION Payara deploy failed!" PROXY &> /dev/null
    echo "Payara deploy failed!"
  exit'
