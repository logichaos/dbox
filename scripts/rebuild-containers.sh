#!/usr/bin/env bash
set -euo pipefail

# Rebuild one or both distrobox containers defined in distrobox.ini
# Usage: rebuild-containers.sh [system|dev|all]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INI_FILE="$SCRIPT_DIR/../distrobox.ini"

usage() {
    cat <<EOF
Usage: $0 [system|dev|all]

Rebuilds the specified distrobox container(s) using distrobox.ini.
 - system : rebuild only the [system] container
 - dev    : rebuild only the [dev] container
 - all    : rebuild both containers (default)
EOF
    exit 1
}

if [ $# -eq 0 ]; then
    TARGETS=(all)
else
    TARGETS=("$@")
fi

for t in "${TARGETS[@]}"; do
    case "$t" in
        system)
            echo "==> Rebuilding 'system' container..."
            distrobox assemble create --file "$INI_FILE" --section system --replace --start
            echo "==> Running system post-setup..."
            bash "$SCRIPT_DIR/setup-system.sh"
            ;;
        dev)
            echo "==> Rebuilding 'dev' container..."
            distrobox assemble create --file "$INI_FILE" --section dev --replace --start
            echo "==> Running dev post-setup..."
            bash "$SCRIPT_DIR/setup-dev.sh"
            ;;
        all)
            echo "==> Rebuilding both containers..."
            distrobox assemble create --file "$INI_FILE" --replace --start
            echo "==> Running system post-setup..."
            bash "$SCRIPT_DIR/setup-system.sh"
            echo "==> Running dev post-setup..."
            bash "$SCRIPT_DIR/setup-dev.sh"
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown target: $t"
            usage
            ;;
    esac
done

echo "==> Done."
