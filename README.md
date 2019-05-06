# Microsoft SQL Server 2017 with tools
Container of Microsoft SQL Server 2017 with tools with latest updates from Microsoft repository. This popular database engine, runs under Linux Ubuntu release 1604.
## Run the container
If you need, you can pull this image with `docker push csgrimberg/mssql2017:ubuntu-1604` and then run the container with this command:
```bash
docker run --rm -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=YourStrongPassword' -e 'MSSQL_PID=Express' -p 0.0.0.0:1433:1433 -v dbdata:/var/opt/mssql --name docker_testdb_1 -d interfaz-sap-sifra:latest
```
Otherwise, you can download the [docker-compose file](docker-compose.yml) and run this command (_go to the folder where the file was downloaded_):
```bash
docker-compose up -d
```
You can see the SQL Server instalation info running this command:
```bash
docker exec docker_testdb_1 /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'YourStrongPassword' -Q 'SELECT @@VERSION'
```
> This container has configured with Buenos Aires time zone.