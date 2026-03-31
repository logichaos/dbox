#!/bin/bash
set -euo pipefail

VERSION=$(curl -L -sS -H 'Accept: application/json' https://github.com/Lifailon/lazyjournal/releases/latest | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
if [ -z "$VERSION" ]; then
    echo "Error: unable to get latest lazyjournal version"
    exit 1
fi

curl -L -sS "https://github.com/Lifailon/lazyjournal/releases/download/$VERSION/lazyjournal-$VERSION-linux-amd64" -o /usr/local/bin/lazyjournal
chmod +x /usr/local/bin/lazyjournal
echo "Installed lazyjournal $VERSION to /usr/local/bin/lazyjournal"
