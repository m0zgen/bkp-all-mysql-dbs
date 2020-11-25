#!/bin/bash
# Author: Yevgeniy Goncharov aka xck, http://sys-adm.in
# Collect and backup all databases except system DBs

# Sys env / paths / etc
# -------------------------------------------------------------------------------------------\
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

# Connection creds and backup destination
# -------------------------------------------------------------------------------------------\
USER="root"
PASSWORD=""
BKP="$SCRIPT_PATH/backups"

if [[ ! -d $BKP ]]; then
  mkdir -p $BKP
fi

#rm "$BKP/*gz" > /dev/null 2>&1

excludeDatabases="Database|information_schema|performance_schema|mysql"
databases=`mysql -u $USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | egrep -v $excludeDatabases`

for db in $databases; do
    echo "Dumping database: $db"
    mysqldump -u $USER -p$PASSWORD --databases $db > $BKP/$db.backup-`date +%Y%m%d`.sql
    gzip $BKP/$db.backup-`date +%Y%m%d`.sql
done
