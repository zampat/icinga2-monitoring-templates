# Configuration of Fileshipper

```
# mkdir /neteye/shared/icingaweb2/conf/modules/fileshipper
# cat >>/neteye/shared/icingaweb2/conf/modules/fileshipper/import.ini <<EOM
> [NetEye File import]
> basedir="/neteye/shared/httpd/file-import"
> EOM
# chown -R apache:icingaweb2 /neteye/shared/icingaweb2/conf/modules/fileshipper/
```
