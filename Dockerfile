# SQL Server 2017 for Ubuntu 16.04
FROM ubuntu:16.04

# Label of the container
LABEL maintainer="Microsoft SQL Server 2017 with tools for Linux"

ENV DEBIAN_FRONTEND noninteractive

# Install apt-get and system utilities
RUN apt-get update \
    && apt-get install -y \
    curl apt-utils apt-transport-https debconf-utils vim screenfetch

# Import the Microsoft public repository GPG keys
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Register the Microsoft SQL Server engine & tools for Ubuntu
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list | tee /etc/apt/sources.list.d/mssql-server.list

# Install SQL Server drivers
RUN apt-get update \
    && ACCEPT_EULA=Y apt-get install -y unixodbc-dev msodbcsql 

# Install SQL Server tools
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

# Install necessary locales
RUN apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen

# Install SQL Server engine
RUN apt-get install mssql-server -f -y

# Delete update cached files
RUN rm -rf /var/lib/apt/lists/*

# Buenos Aires Time Zone
ENV TZ=America/Buenos_Aires
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# Default SQL Server TCP/Port
EXPOSE 1433

# Run SQL Server process.
CMD [ "/opt/mssql/bin/sqlservr" ]