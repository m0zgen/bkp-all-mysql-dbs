## All MySQl/MariaDb databases backuper

If you known `root` password from database server, you can change script and add password to `$PASSWORD` variable:

```
...
# Connection creds and backup destination
# -------------------------------------------------------------------------------------------\
USER="root"
PASSWORD="<password>"
BKP="$SCRIPT_PATH/backups"
...
```

and then run `bkb-mysql.sh` script