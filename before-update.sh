#!/bin/bash
# before-update.sh
# Export installed Nextcloud apps
# Accepts arguments
# Usage:
#   ./before-update.sh [container-name] [output-json]
# I have set my defaults pbased on my own environment, adjust accordingly.

set -euo pipefail

CONTAINER="${1:-nc_app}"
OUTPUT_JSON="${2:-$HOME/nextcloud-apps.json}"

echo "Exporting installed Nextcloud apps from container '$CONTAINER'..."
echo "Saving to: $OUTPUT_JSON"

docker exec -u www-data "$CONTAINER" php occ app:list --output=json > "$OUTPUT_JSON"

echo "Done."
echo "Saved app state to $OUTPUT_JSON"
