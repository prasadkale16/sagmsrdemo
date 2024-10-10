FROM softwareag/webmethods-microservicesruntime:10.15

copy ./config/test.json /opt/softwareag/IntegrationServer/config/test.json
copy ./jars/* /opt/softwareag/IntegrationServer/lib/jars/custom/
