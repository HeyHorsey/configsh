#!/bin/bash

# undeploy payara
sudo -i -u PROJ sh -c 'websmc_payara_undeploy'

# stop env
cd
./PROJ_stop.sh

# update system

export sinst="not ok"
until [ "$sinst" == "OK" ]
do
  yum clean all
  if ! yum update -y --disablerepo=* --enablerepo=TOSREPO $@; then
    sudo -i -u PROJ sh -c '#tgmesg "PROJ VERSION update failed, please proceed manually!"'
    echo  'PROJ VERSION update failed, please proceed manually!'
    exit 1
  fi
  echo "Type OK to continue or skip to repeat"
  read sinst
done

# DB patch
sudo -i -u PROJ sh -c dbpatch

# Post install
sudo -i -u PROJ sh -c postinstall

# Additional sql patches (optional)
#sudo -i -u PROJ sh -c 'sqlplus -S $DB_USER/$DB_PASSWD@$DB_NAME @ /sql_ee/catalog.sql'

# Print versions for delivery note
sudo -i -u PROJ sh -c versions
sudo -i -u PROJ sh -c '#tgmesg "$(versions)"'

# System start
./PROJ_start.sh

# Deploy payara
sudo -i -u PROJ payaradeploy

# Finish
sudo -i -u PROJ sh -c '#tgmesg "$(ucomplete)"'
