#!/bin/bash 

#sript will craete a database for application 
#Execute it on the DB server.


echo "Enter database nane: "
read DATABASE

#Crate user passwrod 

USRMYQLP=`tr -dc A-Za-z0-9 </dev/urandom | head -c 20`
export USRMYQLP="${USRMYQLP:6:8}4hD"

APPUSER='usr'${DATABASE}
echo 
echo "application user: "${APPUSER}
echo "MySQL passwrod:   " ${USRMYQLP}

echo "${APPUSER}ot:${USRMYQLP}" > ~/.private/.my.p

mysql --login-path=r3306 -e "CREATE USER '${APPUSER}'@'10.10.1.%' IDENTIFIED BY '${USRMYQLP}';" 
mysql -u root -e "create database ${DATABASE};" 
mysql -u root -e "GRANT ALL PRIVILEGES ON ${APPUSER}.* TO '${DATABASE}'@'10.10.1.%';"  
mysql -u ${APPUSER} -p${USRMYQLP} -e "show databases"  


