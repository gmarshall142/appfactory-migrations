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
__FLYWAY_HOME__ - path to flyway  
__POSTGRES_OWNER__ - owner role  
__POSTGRES_OWNER_PSWD__ - owner role password  

#### flyway.sh
A bash script for running __flyway__ is included with the intention of using environment variables and the 
conf/appfactory.conf configuration file that provides the settings needed to update the __appfactory__ database.  The
appfactory.conf file can be modified as needed by each database instance.

#### Create roles (if roles have not been created in the postgres instance)
create role appowner with login password '*password*';  
create role appuser with login password '*password*';

#### Create database and schemas (*create-database-schemas.sql*)
CREATE DATABASE appfactory;  
CREATE SCHEMA app;  
ALTER SCHEMA app OWNER TO appowner;  
CREATE SCHEMA metadata;  
ALTER SCHEMA metadata OWNER TO appowner;

#### Check instance version info
cd workspace/app-factory/appfactory-migrations  
./flyway.sh info    

#### Create baseline
./flyway.sh baseline

#### Migrations
./flyway.sh migrate

## Running __flyway__ in Docker
Flyway can be run from a Docker container using instructions found on the [flyway](https://flywaydb.org/ "Flyway link") 
site.  The issues in running from Docker center on accessing a custom configuration file and the resolving the database URL.  
A __flyway-docker.sh__ script has been included which uses the __conf/appfactory.conf__ configuration file and resolves issues 
connecting with the Postgresql database running on the host.  The following steps were key:
* Config file - create a docker volume by adding a reference to the local __conf__ directory and use the volume in the
configFiles option:
  * -v "$(pwd)":/host
  * -configFiles=/host/conf/appfactory.conf
* Postgresql URL - in this case the connection was to a postgresql database running on the host.  In order to resolve 
__localhost__ as the host machine it was necessary to use the __host.docker.internal__ name as the DNS.
  * -url=jdbc:postgresql://host.docker.internal:5432/appfactory
