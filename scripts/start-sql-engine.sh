#!/bin/bash

Wait=10
echo Waiting to $Wait seconds to starting SQL Server Engine...
while sleep $Wait
do
    cat /var/opt/mssql/log/errorlog
    break
done