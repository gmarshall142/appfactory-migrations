#!/bin/bash

# $FLYWAY_HOME/flyway -user=$POSTGRES_OWNER -password=$POSTGRES_OWNER_PSWD -configFiles=conf/appfactory.conf $1
docker run \
-v "$(pwd)":/host \
boxfuse/flyway:5.2.4 \
-user=$POSTGRES_OWNER -password=$POSTGRES_OWNER_PSWD \
-configFiles=/host/conf/appfactory.conf \
-locations=filesystem:/host/migrations \
-url=jdbc:postgresql://host.docker.internal:5432/appfactory \
-X $1

