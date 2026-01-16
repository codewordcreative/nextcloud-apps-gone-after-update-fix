# Backup and restore your Nextcloud apps before and after updates

It's that simple.

If you've been having that issue with your apps disappearing between (manual or docker-based) updates, then this will get you back up and running faster - resolving that weird state when it thinks things are installed when they're not and so on.

Copy scripts.

sudo chmod +x them both to make them executable.

Run one before your update to back up your app list as a json in your user home directory. 
./before-update.sh

Do your update.

Then run the other to have it run through all your apps. Some will already be installed or technically not installable - doesn't matter. It'll get everything missing up and running again.
./after-update.sh

It's not genius; it's time-saving.
