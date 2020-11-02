#!/bin/bash

# undeploy payara
sudo -i -u PROJ sh -c 'websmc_payara_undeploy'

# stop env
cd
./PROJ_stop.sh

# update system

until [ "$sinst" == "OK" ]
do
  yum clean all
  if ! yum update -y --disablerepo=* --enablerepo=TOSREPO $@; then
    #curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="PROJ VERSION update failed, please proceed manually!" &> /dev/null
    echo  'PROJ VERSION update failed, please proceed manually!'
    exit 1
  fi
  read sinst
done

# DB patch
sudo -i -u PROJ sh -c 'cd ~/mdd/ ; rm patch.sql ; make patch.sql ; rm patch.log ; rm patch.err.log ; make dbpatch | tee patch.log ; grep -5 ORA patch.log > patch.err.log'
sudo -i -u PROJ sh -c '#curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="Please see dbpatch errors for PROJ VERSION" &> /dev/null'
sudo -i -u PROJ sh -c '#curl -F document=@mdd/patch.err.log https://api.telegram.org/botTOKEN/sendDocument?chat_id=CHATID &> /dev/null'

# Post install
sudo -i -u PROJ sh -c postinstall

#sudo -i -u PROJ sh -c 'sqlplus -S $DB_USER/$DB_PASSWD@$DB_NAME @ /sql_ee/catalog.sql'

# Print versions for delivery note
sudo -i -u PROJ sh -c versions
sudo -i -u PROJ sh -c '#curl -s -X POST https://api.telegram.org/botTOKEN/sendMessage -d chat_id=CHATID -d text="$(versions)" &> /dev/null'

# System start
./PROJ_start.sh

# Deploy payara
#sudo -i -u PROJ payaradeploy
