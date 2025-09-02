#!/bin/bash

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macos"
else
    PLATFORM="linux"
fi

# Create .vscode directory
mkdir -p .vscode

# Copy snippets
cp ~/latex-config/latex.json .vscode/

# Create main settings file
cat > .vscode/settings.json << 'EOF'
{
  // ===== LaTeX-Workshop Settings =====
  "latex-workshop.latex.autoBuild.run": "onSave",
  "latex-workshop.latex.autoClean.run": "onFailed",
  "latex-workshop.latex.recipe.default": "lastUsed",
  "latex-workshop.latex.outDir": "%DIR%/out",
  "latex-workshop.view.pdf.viewer": "tab",
  
  // ===== Snippets Configuration =====
  "latex.snippets.user": [
    "${workspaceFolder}/.vscode/latex.json"
  ],
  
  // ===== Tools =====
  "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "-pdf",
        "-outdir=%OUTDIR%",
        "%DOC%"
      ]
    }
  ],
  
  // ===== File Exclusions =====
  "files.exclude": {
    "**/*.aux": true,
    "**/*.bbl": true,
    "**/*.blg": true,
    "**/*.fdb_latexmk": true,
    "**/*.fls": true,
    "**/*.log": true,
    "**/*.out": true,
    "**/*.toc": true,
    "**/*.synctex.gz": true,
    "**/out": true
  },
EOF

# Add platform-specific PATH configuration
if [[ "$PLATFORM" == "macos" ]]; then
    echo '  "latex-workshop.latex.env": {' >> .vscode/settings.json
    echo '    "PATH": "/Library/TeX/texbin:${env:PATH}"' >> .vscode/settings.json
    echo '  }' >> .vscode/settings.json
else
    echo '  "latex-workshop.latex.env": {' >> .vscode/settings.json
    echo '    "PATH": "/usr/bin:${env:PATH}"' >> .vscode/settings.json
    echo '  }' >> .vscode/settings.json
fi

# Close the JSON
echo '}' >> .vscode/settings.json

echo "LaTeX configuration installed for $PLATFORM!"
