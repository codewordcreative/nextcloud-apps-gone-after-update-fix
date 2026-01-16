#!/bin/bash
# after-update.sh
# Accepts arguments
# Usage: ./after-update.sh [path-to-json] [container-name]
# Defaults based on my own setup, but you probably want to change these.

# JSON file exported by before-update.sh
INPUT_JSON="${1:-$HOME/nextcloud-apps.json}"
# Container name
CONTAINER="${2:-nc_app}"

if [ ! -f "$INPUT_JSON" ]; then
    echo "Error: file $INPUT_JSON not found."
    exit 1
fi

echo "Copying $INPUT_JSON into container $CONTAINER..."
docker cp "$INPUT_JSON" "$CONTAINER":/var/www/html/nextcloud-apps.json

echo "Reinstalling apps from saved state..."
docker exec -u www-data "$CONTAINER" php -r '
$json = json_decode(file_get_contents("/var/www/html/nextcloud-apps.json"), true);

if (isset($json["enabled"])) {
    foreach($json["enabled"] as $appId => $version) {
        echo "Installing/enabling $appId\n";
        system("php occ app:install $appId");
        system("php occ app:enable $appId");
    }
}

if (isset($json["disabled"])) {
    foreach($json["disabled"] as $appId => $version) {
        echo "Installing/disabling $appId\n";
        system("php occ app:install $appId");
        system("php occ app:disable $appId");
    }
}
'

echo "Removing the file temporarily copied into the container..."
docker exec -u www-data "$CONTAINER" rm /var/www/html/nextcloud-apps.json

echo "All apps restored to previous state."
