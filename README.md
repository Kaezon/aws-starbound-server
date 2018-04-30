# aws-starbound-server
AWS automation for Starbound servers

This documentation will assume basic knowledge of AWS and SteamCMD.

## AWS services used by this project
- EC2
- EFS

## Requirements
- [rcon-cli](https://github.com/itzg/rcon-cli)
- [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD)

## Setup
1. Set up your EFS, Security Groups, and Elastic IP
1. Access your EFS and set up the directory structure as described later in this readme.
1. Place scripts into their appropriate locations on the EFS.
1. Download the latest version of rcon-cli to `$EFS_ROOT/bin`
1. Set up your Starbound server install
    1. Download SteamCMD to wherever you like
    1. Use SteamCMD to download the Starbound Dedicated Server (APPID 533830) to `$EFS_ROOT/starbound`
    1. Add mods to `$EFS_ROOT/starbound/mods` as desired
1. Create your EC2 instance
    1. Use a derivative of the AWS Linux AMI
    1. The instance will need a fair bit of storage on the root volume (>=50GB recommended)
    1. Paste the contents of user-data.txt into the User Data field and edit the values as necessary

The rest should happen automatically once you start the server.

Once the server finishes initializing, you should go and edit the server config at `/home/$STARBOUND_USER/starbound/storage/starbound_server.conf`
and restart the starbound-server service.

## EFS Directory Structure

The following is how I structured my EFS:
```
backups/
backups/starbound/
bin/
cron/
cron/starbound/
scripts/
scripts/aws/
scripts/backup/
scripts/unit/
starbound/
```
