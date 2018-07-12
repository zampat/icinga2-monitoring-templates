Getting started

1) Copy all files to a local folder on your NetEye / Icinga2 environment
   a) users not using NetEye: make sure to have Mariadb up and running and the Icinga2 module "director" enabled.
2) Start import of datafields and host- and service templates

[root@neteye4-demo director_imports]# sh run_import.sh
>> Start of import procedure. Logs are written to import_history.log.
[+] Start SQL injection of file: 0001-director_datafield.sql
[+] Start script import of file: 0002-director_commands.sh
[+] Start script import of file: 0011-generic_host_templates.sh
[+] Start SQL injection of file: 0012-generic_host_templates_template2datafield.sql
[+] Start script import of file: 0021-generic_service_templates.sh
[+] Start SQL injection of file: 0022-generic_service_templates2datafield.sql
[+] Start script import of file: 0031-generic_business_process.sh
[+] Start SQL injection of file: 0032-generic_business_process2datafield.sql
[+] Start script import of file: 1001a-st_neteye.sh
[+] Start script import of file: 1001c-ss_neteye_health.sh
[+] Start script import of file: 1011a-st_http.sh
[+] Start SQL injection of file: 1011b-s2f_http.sql
[+] Start script import of file: 2011a-st_win_agent_basic.sh
[+] Start SQL injection of file: 2011b-s2f_win_agent_basic.sql
[+] Start script import of file: 2011c-ss_win_agent_OS-Basic.sh
[+] Start script import of file: 2012a-st_win_agent_OS-Performance.sh
[+] Start script import of file: 2012c-ss_win_agent_OS-Performance.sh
[+] Start script import of file: 2013a-st_win_agent_extra.sh
[+] Start SQL injection of file: 2013b-s2f_win_agent_extra.sql
[+] Start script import of file: 2021a-st_win_mssql-server.sh
[+] Start SQL injection of file: 2021b-s2f_win_mssql-server.sql
[+] Start script import of file: 2021c-ss_win_mssql-server.sh
[+] Start script import of file: 2031a-st_win_exchange.sh
[+] Start SQL injection of file: 2031b-s2f_win_exchange.sql
[+] Start script import of file: 2031c-ss_win_exchange.sh
[+] Start script import of file: 2051a-st_win_agent_AX-AOS.sh
[+] Start script import of file: 3001a-st_vmware_esx.sh
[+] Start script import of file: 4001a-st_linux_agent-OS-Basic.sh
[+] Start script import of file: 4011a-st_linux_agent-debian.sh

3) Consult import logs
[root@neteye4-demo director_imports]# cat import_history.log
>> Start of import procedure. Date:  Thu Jul 12 15:19:18 CEST 2018
dos2unix: converting file 0001-director_datafield.sql to Unix format ...
[+] Start SQL injection of file: 0001-director_datafield.sql
dos2unix: converting file 0002-director_commands.sh to Unix format ...
[+] Start script import of file: 0002-director_commands.sh
dos2unix: converting file 0011-generic_host_templates.sh to Unix format ...
[+] Start script import of file: 0011-generic_host_templates.sh
Generic Host Templates created
dos2unix: converting file 0012-generic_host_templates_template2datafield.sql to Unix format ...
[+] Start SQL injection of file: 0012-generic_host_templates_template2datafield.sql
dos2unix: converting file 0021-generic_service_templates.sh to Unix format ...
[+] Start script import of file: 0021-generic_service_templates.sh
Service Templates created
dos2unix: converting file 0022-generic_service_templates2datafield.sql to Unix format ...
[+] Start SQL injection of file: 0022-generic_service_templates2datafield.sql
dos2unix: converting file 0031-generic_business_process.sh to Unix format ...
[...]