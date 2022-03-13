#!/bin/bash 

#sript will craete a database for application 
#Execute it on the DB server.

if (whoami != root)
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

echo "${APPUSER}ot:${USRMYQLP}" > ~/.private/.my.p

mysql --login-path=r3306 -e "CREATE USER '${APPUSER}'@'10.10.1.%' IDENTIFIED BY '${USRMYQLP}';" 
mysql --login-path=r3306 -e "create database ${DATABASE};" 
mysql --login-path=r3306 -e "GRANT ALL PRIVILEGES ON ${APPUSER}.* TO '${DATABASE}'@'10.10.1.%';"  
mysql -u ${APPUSER} -p${USRMYQLP} -e "show databases"  

exit
 