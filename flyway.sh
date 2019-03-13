#!/bin/bash

$FLYWAY_HOME/flyway -user=$POSTGRES_OWNER -password=$POSTGRES_OWNER_PSWD -configFiles=conf/appfactory.conf $1

