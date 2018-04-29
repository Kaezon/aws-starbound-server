#! /bin/bash

# Starbound Backup Script:
# This is a workaround to address the file lock issue that prevents Starbound
# from running on the EFS mount.
#
# Passing anything as the first argument to this script supresses shutdown warnings
# and leaves ther server down after backup.

BACKUP_NAME=$(date +"starbound-backup_%m-%d-%Y_%H-%M-%S.zip")

if [ -z $BACKUP_PATH ] || [ -z $ARCHIVE_PATH ] || [ -z $STARBOUND_USER ] || [ -z $STARBOUND_PORT ] || [ -z $STARBOUND_PATH ]; then
	echo "ERROR: Not all required environment variables are set!"
	exit 1
fi

RCON_PASSWORD=$(grep 'rconServerPassword' /home/$STARBOUND_USER/starbound/storage/starbound_server.config | awk '{ print $3 }' | sed 's/\"//g' | sed 's/\,//g')

zip -r "$ARCHIVE_PATH/$BACKUP_NAME" "$BACKUP_PATH/starbound"

if [ -z $1 ]; then
	/mnt/efs/bin/rcon-cli --host localhost --port $STARBOUND_PORT --password $RCON_PASSWORD "say The server will shut down for backup in 10 minutes!"
	sleep 300
	/mnt/efs/bin/rcon-cli --host localhost --port $STARBOUND_PORT --password $RCON_PASSWORD "say The server will shut down for backup in 5 minutes!"
	sleep 240
	/mnt/efs/bin/rcon-cli --host localhost --port $STARBOUND_PORT --password $RCON_PASSWORD "say The server will shut down for backup in 60 seconds!"
	sleep 55
	/mnt/efs/bin/rcon-cli --host localhost --port $STARBOUND_PORT --password $RCON_PASSWORD "say The server will now shut down for backup..."
	sleep 5
fi

systemctl stop starbound-server
rsync -az $STARBOUND_PATH $BACKUP_PATH --delete
if [ -z $1 ]; then
	systemctl start starbound-server
fi
