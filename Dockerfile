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

# Install .Net Core 5 SDK and Runtime
RUN wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y apt-transport-https dotnet-sdk-5.0 dotnet-runtime-5.0

# Add support to .Net Entity Framework Core
RUN dotnet tool install --global dotnet-ef --version 5.0.3

# Clear aptitude files
RUN rm -rf /var/lib/apt/lists/*

# Install necessary locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen

# Buenos Aires Time Zone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# Add Scripting tasks to container
RUN mkdir /var/opt/mssql/scripts
ADD scripts/start-sql-engine.sh /var/opt/mssql/scripts/
RUN chmod +x /var/opt/mssql/scripts/start-sql-engine.sh

# Default SQL Server TCP/Port
EXPOSE 1433

# Run SQL Server process.
CMD [ "/opt/mssql/bin/sqlservr" ]
