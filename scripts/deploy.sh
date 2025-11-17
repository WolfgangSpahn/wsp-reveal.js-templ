#!/usr/bin/env bash

set -e

echo "🧹 Cleaning public directory..."
rm -rf public
mkdir -p public

echo "📁 Copying your source files..."
cp -r src/* public/

echo "📦 Copying Reveal.js distribution files..."
if [ -d "reveal.js" ]; then
  mkdir -p public/reveal.js/dist
  mkdir -p public/reveal.js/plugin
  
  # Copy Reveal.js core files
  if [ -d "reveal.js/dist" ]; then
    cp -r reveal.js/dist/* public/reveal.js/dist/
  fi
  if [ -d "reveal.js/plugin" ]; then
    cp -r reveal.js/plugin/* public/reveal.js/plugin/
  fi
else
  echo "⚠️  reveal.js directory not found - run 'make install' first"
fi

echo "📦 Copying plugins and vendor libraries..."
mkdir -p public/plugins
mkdir -p public/vendor

# Copy third-party plugins (separate from reveal.js/plugin)
if [ -d "plugins" ]; then
  cp -r plugins/* public/plugins/
else
  echo "⚠️  plugins directory not found"
fi

# Copy vendor libraries
if [ -d "vendor" ]; then
  cp -r vendor/* public/vendor/
else
  echo "⚠️  vendor directory not found"
fi

echo "⚙️  Copying configuration files..."
mkdir -p public/config
if [ -d "config" ]; then
  cp -r config/* public/config/
fi

echo "✨ Deployment complete!"
echo "📂 Public directory structure:"
tree -L 2 public 2>/dev/null || ls -R public
