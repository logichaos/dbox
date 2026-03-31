#!/bin/bash
set -euo pipefail
CONTAINER="system"

echo "Verifying system container packages..."
for bin in nvim lazygit jj yazi nwg-displays btop atop lazyjournal delta; do
    if distrobox enter "$CONTAINER" -- which "$bin" > /dev/null 2>&1; then
        echo "  [ok] $bin"
    else
        echo "  [MISSING] $bin"
        exit 1
    fi
done

echo "Configuring git-delta..."
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global delta.dark true
git config --global merge.conflictStyle zdiff3
echo "  [ok] git config"

echo "System container setup complete."
