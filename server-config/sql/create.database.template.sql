drop user 'APPUSER'@'10.10.1.%';
CREATE USER 'APPUSER'@'10.10.1.%' IDENTIFIED BY 'USRMYQLP';
create database DATABASE_NAME;
GRANT ALL PRIVILEGES ON ${APPUSER}.* TO 'APPUSER'@'10.10.1.%';
exit;
