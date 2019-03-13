# appfactory-migrations

### Overview
The appfactory-migrations repo contains [flyway](https://flywaydb.org/ "Flyway link") migrations for the 
Postgresql __appfactory__ database.  The project contains a bash script for calling flyway and uses the 
conf/appfactory.conf configuration file which provides flyway settings for the appfactory database and schemas.

Setting up the database requires the manual creation of roles, the appfactory database, and the schemas.  Since the roles
will be present in an instance even if the database is dropped and recreated they can be added manually when the postgres
database is setup.  The script __scripts/create-dataabase-schemas.sql__ can be run to create the database, schemas, and 
assign the owner as needed.  This would be normal in a developer or test instance.

#### Environment Variables

#### flyway.sh

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

#### Migrations
./flyway.sh migrate
