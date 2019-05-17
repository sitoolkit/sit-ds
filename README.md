# Dev Servers

Dev Servers is a Docker Compose asset to setup server tools for CI / CD.
It setups the following tools with Docker and makes them available immediately.

* Souce Code Management : GitBucket
* Continuous Integration : Jenkins
* Static Code Analysis : SonarQube
* Issue Tracking System : Redmine

Each server tool is configured as a service of Docker Compose.
Each service has the following settings necessary for team development.

* LDAP Authentication
  * You can log in to all tools with the same user ID / password.
* Proxy Server
  * It can be accessed via the same proxy server.
* Self Service Password
  * Users can change passwords and send reminders.
* E-mail
  * You can set the connection information of the SMTP server of each service in one place.
  * The e-mail address of the LDAP user account is used as the mail transmission destination.


## Quick Start

1. Install Docker.
  * Windows 10 Pro / Mac
    * https://store.docker.com/search?type=edition&offering=community
  * Another Windows
    * https://docs.docker.com/toolbox/toolbox_install_windows/
1. Set the memory allocation of Docker to 4 GB or more.
  * Windows 10 Pro
    * Settings > Advanced > Memory
  * Mac
    * Preferences > Advanced > Memory
1. Get the resource of SIT-DS and execute each Docker Compose Service with the following command.

```
git clone https://github.com/sitoolkit/sit-ds.git
cd sit-ds
docker-compose up -d
```

The endpoint URL to each service and the connection information of the admin user are as follows.

|        Server         |             Endpoint URL (*1)             |         UserId / Password          |
| --------------------- | ----------------------------------------- | ---------------------------------- |
| GitBucket             | http://localhost/gitbucket                | root  / root                       |
| Jenkins               | http://localhost/jenkins                  | admin / admin                      |
| SonarQube             | http://localhost/sonarqube                | admin / admin                      |
| Redmne                | http://localhost/redmine                  | admin / admin                      |
| PostgreSQL            | jdbc:postgresql://localhost:5432/postgres | postgres / postgres                |
| Self Service Password | http://localhost/passchg                  | admin / admin                      |
| phpLDAPAdmin          | https://localhost:6443                    | cn=admin,dc=example,dc=org / admin |

* *1 For Docker Toolbox, it is an IP address that can be confirmed with docker-machine ls command instead of localhost.


### How To Add Users

1. Create new ldif file and add the user information you want to add.

* add-users.ldif

```
dn: cn=user001,dc=example,dc=org
changetype: add
cn: user001
sn: User
givenName: 001
mail: user001@exapmle.org
objectClass: inetOrgPerson
objectClass: person
objectClass: top
userPassword: password
```

2. Execute the following command.

```
docker cp add-users.ldiff sit-ds_work_1:/tmp
docker-compose exec work ldapmod add-users.ldif
```

Then you can log in to all services with the following user ID / password.

* user001 / password


### Backup

1. Execute backup.sh specifing the directory you want to save backup files.
   1. All services will be stopped.
   2. All named volumes in docker-compose.yml will be backuped to backup/{timestamp} directory.
   3. 8th and subsequent directories in order of age will be deleted. 
   4. All services will be started.

```
./backup.sh /path/to/backup/directory
```


```
/path/to/backup/directory
  - yyyymmdd_hhmmss
    - ci_data.tar
    - dbms_data.tar
      :
```

### Restore

1. Execute restore.sh specifing the path of the backup file you want to restore.
   Read and restore tar file of "sit-ds_" prefix of specified directory.

```
git clone https://github.com/sitoolkit/sit-ds.git
cd sit-ds
./restore.sh /dir/path/with/backup-files
docker-compose up -d
```