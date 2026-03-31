#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Assembling distrobox containers..."
distrobox assemble create --file "$SCRIPT_DIR/distrobox.ini"

echo ""
echo "==> Running system container post-setup..."
bash "$SCRIPT_DIR/scripts/setup-system.sh"

echo ""
echo "==> Running dev container post-setup..."
bash "$SCRIPT_DIR/scripts/setup-dev.sh"

echo ""
echo "==> All containers set up successfully."
echo "    Exported binaries are in ~/.local/bin"
echo "    Make sure ~/.local/bin is in your PATH."
