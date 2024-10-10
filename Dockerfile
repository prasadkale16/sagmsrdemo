FROM softwareag/webmethods-microservicesruntime:10.15

copy ./config/test.json /opt/softwareag/IntegrationServer/config/test.json
copy ./jar/* /opt/softwareag/IntegrationServer/lib/jars/custom/
