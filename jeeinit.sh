#!/bin/bash
mkdir -p ~/JEE/lib/mssql
wget -c http://repo2.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/6.1.0.jre8/mssql-jdbc-6.1.0.jre8.jar -O ~/JEE/lib/mssql/mssql-jdbc-6.1.0.jre8.jar
mkdir -p ~/JEE/wildfly-10.1.0.Final/modules/system/layers/base/com/mssql/jdbc/main
cp ~/JEE/lib/mssql/mssql-jdbc-6.1.0.jre8.jar ~/JEE/wildfly-10.1.0.Final/modules/system/layers/base/com/mssql/jdbc/main
cp mssqlmodule.xml ~/JEE/wildfly-10.1.0.Final/modules/system/layers/base/com/mssql/jdbc/main/module.xml
~/JEE/wildfly-10.1.0.Final/bin/standalone.sh > /dev/null 2>&1 &
sleep 2s
~/JEE/wildfly-10.1.0.Final/bin/jboss-cli.sh --connect --command=version
~/JEE/wildfly-10.1.0.Final/bin/jboss-cli.sh --connect --command="/subsystem=datasources/jdbc-driver=mssql:add(driver-name=mssql,driver-module-name=com.mssql.jdbc, driver-class-name=com.microsoft.sqlserver.jdbc.SQLServerDriver)"
~/JEE/wildfly-10.1.0.Final/bin/add-user.cli
~/JEE/wildfly-10.1.0.Final/bin/jboss-cli.sh --connect --command=reload
~/JEE/wildfly-10.1.0.Final/bin/jboss-cli.sh --connect --command=shutdown
