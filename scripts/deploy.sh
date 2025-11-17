#!/usr/bin/env bash

set -e

echo "🧹 Cleaning public directory..."
rm -rf public
mkdir -p public

echo "📁 Copying your source files..."
cp -r src/* public/

echo "📦 Copying Reveal.js distribution files..."

mkdir -p public/dist
mkdir -p public/plugin

# Copy CONTENTS of dist/ and plugin/ instead of folders
cp -r reveal.js/dist/* public/dist/
cp -r reveal.js/plugin/* public/plugin/

echo "✨ Deployment complete!"
tree -L 2 public
