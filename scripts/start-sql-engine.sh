#!/bin/bash

Wait=20
i=0
echo Waiting to starting SQL Server Engine...
sleep 1.5
while [ $i -lt $Wait ];
do
    tail -n 1 /var/opt/mssql/log/errorlog
    let "i++"
    sleep 0.1
done