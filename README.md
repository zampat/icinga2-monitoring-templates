# Update advice !

Advice: The icinga2 director templates had been refactored completely. Naming conventions had been introduced.
        The import of objects is now controled by parameter - choose one from below.


Legacy advice: If you would like to use the old templates checkout branch legacy_templates_v1
        https://github.com/zampat/icinga2-monitoring-templates/tree/legacy_templates_v1
        
# Introduction

This Repository provides a list of monitoring objects to be imported to Icinga2 Director to accelerate the start of your project.

The archive contains the following types of director objects:
- Director Datafields
- Director Latalists
- Icinga commands
- Host templates
- Service Templates
- Assignment of Fields to Service Templates
- Service Sets and assignment of service templates

## Monitoring templates

The provided templates are suitable for a quick monitoring start for the following monitoring purpose:
- Basic OS independent monitoring (Ping, HTTP, etc.)
- NetEye 
- Basic Microsoft OS
- Basic Microsoft OS Performance
- Basic Microsoft SQL Server
- Basic Microsoft Exchange Server
- Basic Linux

## Getting started

### Requirement
- Mariadb
- Director > 1.4
- Icinga > 2.8

1) Clone repository to local system. 
   Path for NetEye /neteye/shared/neteyeshare/monitoring/monitoring-templates
```
git clone https://github.com/zampat/icinga2-monitoring-templates.git
```

2) Perform import im templates and fields

Info: Import is performed using Icingacli and sql queries. Make sure to have Mariadb up and running and module "director" enabled.
```
./run_import.sh <action>
./run_import.sh full           import of all icinga2 objects
./run_import.sh full_legacy    import of all legacy icinga2 objects
./run_import.sh fields         icinga2 director fields only
```

3) Consult import logs
Import logs are written 
```
cat import_history.log
```
