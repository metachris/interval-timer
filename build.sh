#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Create panthers directory
mkdir -p panthers

# Copy supporting files
sed \
  -e 's|reflex-coach-v|reflex-coach-panthers-v|' \
  -e 's|kubi\.jpeg|team.jpeg|' \
  sw.js > panthers/sw.js
cp -r assets panthers/

# Replace with panthers-specific assets
cp assets/favicon-panthers.svg panthers/assets/favicon.svg
cp assets/icon-panthers-192.png panthers/assets/icon-192.png
cp assets/icon-panthers-512.png panthers/assets/icon-512.png
cp assets/og-image-panthers.svg panthers/assets/og-image.svg
cp assets/og-image-panthers.png panthers/assets/og-image.png

# Build modified manifest with correct paths
sed \
  -e 's|/reflex-coach/"|/reflex-coach/panthers/"|g' \
  manifest.webmanifest > panthers/manifest.webmanifest

# Build modified index.html for Panthers version
sed \
  -e 's|<!-- \(<img class="surprise-img".*team\.jpeg[^>]*>\) -->|\1|' \
  -e 's|\(<img class="surprise-img".*kubi\.jpeg[^>]*>\)|<!-- \1 -->|' \
  -e 's|--accent: #d4ff00;|--accent: #ffd700;|' \
  -e 's|--accent-dim: #6a8000;|--accent-dim: #997a00;|' \
  -e 's|rgba(212, 255, 0,|rgba(255, 215, 0,|g' \
  -e 's|/reflex-coach/assets/|/reflex-coach/panthers/assets/|g' \
  index.html > panthers/index.html

echo "Built panthers version to ./panthers/"
