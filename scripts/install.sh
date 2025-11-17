#!/usr/bin/env bash

# ask for cleaning up existing setup
if [ -d "reveal.js" ]; then
  read -p "The 'reveal.js' directory already exists. Do you want to remove it and start fresh? (y/n) " choice
  if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    echo "🧹"
    rm -rf reveal.js
  else
    echo "❌ Setup aborted."
    exit 1
  fi
fi

set -e  # stop on error

echo "📁 Creating project structure..."
mkdir -p src
mkdir -p src/slides
mkdir -p public

# clone Reveal.js only if not already present
if [ ! -d "reveal.js" ]; then
  echo "⬇️  Cloning Reveal.js..."
  git clone https://github.com/hakimel/reveal.js.git reveal.js
else
  echo "✔️  reveal.js directory already exists — skipping clone."
fi

echo "📦 Installing Reveal.js dependencies..."
cd reveal.js
npm install

echo "🛠 Building Reveal.js..."
npm run build

cd ..

echo "✨ Setup complete!"
echo "Your project tree now looks like:"
tree -L 2


