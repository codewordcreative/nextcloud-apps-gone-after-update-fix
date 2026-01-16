# Back up and restore your Nextcloud apps before and after updates (using Docker)

It's that simple.

If you've been having that issue with your apps disappearing between (manual or docker-based) updates, then this will get you back up and running faster - resolving that weird state when it thinks things are installed when they're not and so on.

## Important: This is based on the assumption you use Docker, but not Nextcloud AIO. 

### Nextcloud AIO support
It may or may not work with AIO, but it also may not be necessary. No idea.

### Without Docker
It'll work similarly without Docker, you just don't need the parts where I'm clearly interacting with the container. Feel free to modify, post your own version for your setup, whatever.

## How to

Copy scripts.

sudo chmod +x them both to make them executable.

Run one before your update to back up your app list as a json in your user home directory. 
./before-update.sh

Do your update.

Then run the other to have it run through all your apps. Some will already be installed or technically not installable - doesn't matter. It'll get everything missing up and running again.
./after-update.sh

It's not genius; it's time-saving.
