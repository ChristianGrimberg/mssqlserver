# Microsoft SQL Server with tools

![Build & Publish Container Image](https://github.com/ChristianGrimberg/mssqlserver/workflows/Build%20&%20Publish%20Container%20Image/badge.svg?branch=main)

Image of Microsoft SQL Server with tools with latest updates from Microsoft repository. This popular database engine, runs under Linux Ubuntu release 18.04 LTS.

## Pull this image directly from Docker Hub

You can pull this image from my [Docker Hub](https://hub.docker.com/r/csgrimberg/mssqlserver) with this command:

```bash
docker pull csgrimberg/mssqlserver:latest
```

## Or pull this image directly from GitHub Packages

You can pull this image from my [GitHub Packages](https://github.com/ChristianGrimberg?tab=packages) with this command:

```bash
docker pull docker.pkg.github.com/christiangrimberg/msssqlserver/mssqlserver:latest
```

## Build the Docker container locally

If you need, you can build this container after cloning this repo:

```bash
git clone https://github.com/ChristianGrimberg/mssqlserver.git
docker build -t csgrimberg/mssqlserver:latest mssqlserver/.
```

## Run the container

After that run the container with this command:

```bash
docker run --rm -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=YourStrongPassword1234' -e 'MSSQL_PID=Express' -p 0.0.0.0:1433:1433 -v dbdata:/var/opt/mssql --name docker_mssqlserver -d csgrimberg/mssqlserver:latest
```

## Run with Docker Compose

Otherwise, you can use the [docker-compose file](docker-compose.yml) and run this command (replace with your password in _YourStrongPassword1234_ text in this file):

```bash
docker-compose up -d
```

## See the SQL Server version installed

You can see the SQL Server instalation info running this command (replace with your password in _YourStrongPassword1234_ text in the next line):

```bash
docker exec docker_mssqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongPassword1234' -Q 'SELECT @@VERSION'
```

> This container has configured with Buenos Aires time zone.