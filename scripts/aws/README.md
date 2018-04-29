# watch-termination-time
Credit to Dominic Zippilli who published the basic loop I built this on [here](https://blog.fugue.co/2015-01-06-spot-termination-notices.html).

This script loops forever, checking the instance's metadata to see if termination-time has been set.
When the instance is marked for termination, the script will warn the server that AWS is terminating the instance, then run the backup script with a termination flag.
