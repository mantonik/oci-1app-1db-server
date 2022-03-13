#!/bin/bash 
set -x
#sript will craete a database for application 
#Execute it on the DB server.

if [ "$EUID" -ne 0 ]
  then
    echo ""
    echo "Please run as root"
    echo ""
    exit
fi

echo "Script has to be executed as root user "

echo "Enter database nane: "
read DATABASE

#Crate user passwrod 

USRMYQLP=`tr -dc A-Za-z0-9 </dev/urandom | head -c 20`
export USRMYQLP="${USRMYQLP:6:8}4hD"

APPUSER='usr'${DATABASE}
echo 
echo "application user: "${APPUSER}
echo "MySQL passwrod:   " ${USRMYQLP}

echo "${APPUSER}:${USRMYQLP}" > ~/.private/.my.p

sed "s/${APPUSER}/${APPUSER}/g" < /home/opc/sql/create.database.template.sql > /home/opc/sql/create.database.sql
sed "s/${DATABASE}/${DATABASE_NAME}/g" -i /home/opc/sql/create.database.sql
sed "s/${USRMYQLP}/${USRMYQLP}/g" -i /home/opc/sql/create.database.sql



mysql --login-path=r3306  < /home/opc/sql/create.database.sql

mysql -u ${APPUSER} -p${USRMYQLP} -e "show databases"  

exit
 