# From a SQL Server 2019 image base
FROM mcr.microsoft.com/mssql/server:2019-latest

# Execute as Root User
USER root

# Label of the container
LABEL maintainer="Microsoft SQL Server 2019 with Buenos Aires time zone"

# Set the image environments
ENV TZ=America/Buenos_Aires
ENV DEBIAN_FRONTEND noninteractive
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Install necessary locales
RUN apt-get update \
    && apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen

# Delete update cached files
RUN rm -rf /var/lib/apt/lists/*

# Add Scripting tasks to container
RUN mkdir /var/opt/mssql/scripts
ADD scripts/start-sql-engine.sh /var/opt/mssql/scripts/
RUN chmod +x /var/opt/mssql/scripts/start-sql-engine.sh

# Buenos Aires Time Zone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# Default SQL Server TCP/Port
EXPOSE 1433

# Run SQL Server process.
CMD [ "/opt/mssql/bin/sqlservr" ]
