# appfactory-migrations

docker run -it boxfuse/flyway:5.2.4 -user=$POSTGRES_USER -password=$POSTGRES_PSWD -url=jdbc:postgresql://$POSTGRES_HOST:5432/appfactory info

docker run -it --net="host" boxfuse/flyway:5.2.4 -user=gmarshall -password='P@ssw0rd' -url=jdbc:postgresql://192.168.1.129:5432/appfactory info

./flyway -user=gmarshall -password='P@ssw0rd' -url=jdbc:postgresql://localhost:5432/appfactory info

./flyway -user=$POSTGRES_USER -password=$POSTGRES_PSWD -url=jdbc:postgresql://$POSTGRES_HOST:5432/appfactory info

#### Create roles (if roles have not been created in the postgres instance)
create role appowner with login password '*password*';  
create role appuser with login password '*password*';

#### Create database and schemas (*create-database-schemas.sql*)
CREATE DATABASE appfactory;  
CREATE SCHEMA app;  
ALTER SCHEMA app OWNER TO appowner;  
CREATE SCHEMA metadata;  
ALTER SCHEMA metadata OWNER TO appowner;

#### Create baseline
./flyway.sh baseline
