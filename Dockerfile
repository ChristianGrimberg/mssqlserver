# SQL Server 2017 for Ubuntu 16.04
FROM ubuntu:18.04

# Label of the container
LABEL maintainer="Microsoft SQL Server with tools for Linux"

# Set the envirorments
ENV TZ=America/Buenos_Aires
ENV DEBIAN_FRONTEND noninteractive
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Install system utilities
RUN apt-get update \
    && apt-get install -y \
    curl wget apt-utils apt-transport-https debconf-utils vim screenfetch gnupg gnupg2 gnupg1 software-properties-common

# Import the public repository GPG keys
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Register the Microsoft SQL Server with Tools for Ubuntu repository
RUN add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list)"
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list | tee /etc/apt/sources.list.d/msprod.list

# Install SQL Server drivers
RUN apt-get update \
    && ACCEPT_EULA=Y apt-get install -y unixodbc-dev

# Install SQL Server Tools
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

# Install necessary locales
RUN apt-get install -y locales \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen

# Install SQL Server Engine
RUN apt-get install mssql-server -f -y

# Delete update cached files
RUN rm -rf /var/lib/apt/lists/*

# Buenos Aires Time Zone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# Default SQL Server TCP/Port
EXPOSE 1433

# Run SQL Server process.
CMD [ "/opt/mssql/bin/sqlservr" ]