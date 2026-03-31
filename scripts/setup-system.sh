#!/bin/bash
set -euo pipefail
CONTAINER="system"

echo "Verifying system container packages..."
for bin in nvim lazygit jj yazi nwg-displays; do
    if distrobox enter "$CONTAINER" -- which "$bin" > /dev/null 2>&1; then
        echo "  [ok] $bin"
    else
        echo "  [MISSING] $bin"
        exit 1
    fi
done

echo "Exporting nwg-displays as desktop app..."
distrobox enter "$CONTAINER" -- distrobox-export --app nwg-displays

echo "System container setup complete."
