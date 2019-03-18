#!/bin/bash

$FLYWAY_HOME/flyway -user=$POSTGRES_OWNER -password=$POSTGRES_OWNER_PSWD \
-url=jdbc:postgresql://localhost:5432/appfactory \
-configFiles=conf/appfactory.conf $1

