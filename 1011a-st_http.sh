#
#Service template: HTTP
#

#
#Service template
#
RES=`icingacli director service exists "generic-http"`
if [[ $RES =~ "does not exist" ]]
then

   echo "Service 'generic-http' does not exists"
   icingacli director service create generic-http --json '
{
    "check_command": "http",
    "imports": [
        "generic-active-service"
    ],
    "object_name": "generic-http",
    "object_type": "template",
    "vars": {
        "http_critical_time": 30,
        "http_timeout": 60,
        "http_warn_time": 20
    }
}
'
fi



RES=`icingacli director service exists "http_website_availability"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'http_website_availability' does not exists"
icingacli director service create http_website_availability --json '
{
    "imports": [
        "generic-http"
    ],
    "object_name": "http_website_availability",
    "object_type": "template"
}
'
fi




RES=`icingacli director service exists "http_certificate_validity"`
if [[ $RES =~ "does not exist" ]]
then
   echo "Service 'http_certificate_validity' does not exists"

icingacli director service create http_certificate_validity --json '
{
    "check_interval": "86400",
    "imports": [
        "generic-http"
    ],
    "object_name": "http_certificate_validity",
    "object_type": "template",
    "vars": {
        "http_certificate": "30,14",
        "http_ssl": true
    }
}
'
fi
