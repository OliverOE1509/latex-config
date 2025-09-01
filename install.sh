#!/bin/bash

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macos"
else
    PLATFORM="linux"
fi

# Create .vscode directory in current folder
mkdir -p .vscode

# Copy main settings
cp ~/latex-config/settings.json .vscode/

# Copy platform-specific settings
cp ~/latex-config/settings.$PLATFORM.json .vscode/settings.platform.json

# Copy snippets
cp ~/latex-config/latex.json .vscode/

# Create final settings that extends both
echo '{
  "extends": [
    "./.vscode/settings.json",
    "./.vscode/settings.platform.json"
  ]
}' > .vscode/settings.json

echo "LaTeX configuration installed for $PLATFORM!"
