Liferay 6.2.5 GA6 on Tomcat with Mysql or PostgresSQL (two containers)
==========================================================

Image available in docker registry: https://hub.docker.com/r/oazapater/docker-liferay/

## Pulling:

```
docker pull oazapater/liferay-base
```

## Launching using "docker run":

```
# Run mysql:
docker run --name lep-db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_USER=liferay -e MYSQL_PASSWORD=liferay -e MYSQL_DATABASE=lportal $@ -d mysql:latest

# Run postgres: (Configure by default)
docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=root POSTGRES_USER=root POSTGRES_DB=lportal $@ -d postgres

Check that exist lportal, if not create schema (MySQL) or database (PostgreSQL) with name lportal

# Run liferay:
docker run --name liferay -it --rm -p 80:8080 --link some-postgres -e JAVA_OPTS='-Xmx2048m -XX:MaxPermSize=1024m' oazapater/liferay-base:v1

## Use:

Point browser to docker machine ip (port 80)