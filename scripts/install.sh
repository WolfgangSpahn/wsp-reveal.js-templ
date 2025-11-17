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
mkdir -p plugins
mkdir -p vendor

# clone Reveal.js only if not already present
if [ ! -d "reveal.js" ]; then
  echo "⬇️  Cloning Reveal.js..."
  git clone https://github.com/hakimel/reveal.js.git reveal.js
else
  echo "✔️  reveal.js directory already exists — skipping clone."
fi


# ---------------------------------------------------------------------------- install vendor libraries

  # { type: "script", src: "vendor/socket.io/socket.io.js" },
  # { type: "script", src: "vendor/chart.js/chart.min.js" },
  # { type: "script", src: "vendor/svg.js/svg.min.js" },
  # { type: "style",  href: "vendor/fontawesome/css/all.min.css" },
  # { type: "script", src: "vendor/fontawesome/js/all.min.js" },

# download socket.io
if [ ! -f "vendor/socket.io/socket.io.js" ]; then
  echo "⬇️  Downloading Socket.io..."
  mkdir -p vendor/socket.io
  curl -L -o vendor/socket.io/socket.io.js https://cdnjs.cloudflare.com/ajax/libs/socket.io/4.5.4/socket.io.min.js
else
  echo "✔️  socket.io.js already exists — skipping download."
fi
# download chart.js
if [ ! -f "vendor/chart.js/chart.min.js" ]; then
  echo "⬇️  Downloading Chart.js..."
  mkdir -p vendor/chart.js
  curl -L -o vendor/chart.js/chart.min.js https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.3.0/chart.umd.min.js
else
  echo "✔️  chart.min.js already exists — skipping download."
fi
# download svg.js
if [ ! -f "vendor/svg.js/svg.min.js" ]; then
  echo "⬇️  Downloading SVG.js..."
  mkdir -p vendor/svg.js
  curl -L -o vendor/svg.js/svg.min.js https://cdnjs.cloudflare.com/ajax/libs/svg.js/3.1.2/svg.min.js
else
  echo "✔️  svg.min.js already exists — skipping download."
fi
# download Font Awesome
if [ ! -f "vendor/fontawesome/css/all.min.css" ] || [ ! -f "vendor/fontawesome/js/all.min.js" ]; then
  echo "⬇️  Downloading Font Awesome CSS and JS..."
  mkdir -p vendor/fontawesome/css
  mkdir -p vendor/fontawesome/js
  curl -L -o vendor/fontawesome/css/all.min.css https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css
  curl -L -o vendor/fontawesome/js/all.min.js https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js
else
  echo "✔️  Font Awesome CSS and JS already exist — skipping download."
fi

# download Font Awesome webfonts
if [ ! -f "vendor/fontawesome/webfonts/fa-solid-900.woff2" ] || [ ! -f "vendor/fontawesome/webfonts/fa-regular-400.woff2" ] || [ ! -f "vendor/fontawesome/webfonts/fa-brands-400.woff2" ]; then
  echo "⬇️  Downloading Font Awesome webfonts..."
  mkdir -p vendor/fontawesome/webfonts
  # Solid icons (most commonly used)
  curl -L -o vendor/fontawesome/webfonts/fa-solid-900.woff2 https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/webfonts/fa-solid-900.woff2
  curl -L -o vendor/fontawesome/webfonts/fa-solid-900.ttf https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/webfonts/fa-solid-900.ttf
  # Regular icons
  curl -L -o vendor/fontawesome/webfonts/fa-regular-400.woff2 https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/webfonts/fa-regular-400.woff2
  curl -L -o vendor/fontawesome/webfonts/fa-regular-400.ttf https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/webfonts/fa-regular-400.ttf
  # Brands icons
  curl -L -o vendor/fontawesome/webfonts/fa-brands-400.woff2 https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/webfonts/fa-brands-400.woff2
  curl -L -o vendor/fontawesome/webfonts/fa-brands-400.ttf https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/webfonts/fa-brands-400.ttf
else
  echo "✔️  Font Awesome webfonts already exist — skipping download."
fi


# ---------------------------------------------------------------------------- install plugins extensions

# clone menu plugin only if not already present
if [ ! -d "plugins/menu" ]; then
  echo "⬇️  Cloning Reveal.js Menu plugin..."
  git clone https://github.com/denehyg/reveal.js-menu plugins/menu
else
  echo "✔️  menu directory already exists — skipping clone."
fi

# clone temp plugins to get seminar plugin board, poll and questions plugins
if [ ! -d "plugins/seminar" ]; then
  echo "⬇️  Cloning Reveal.js Seminar plugin..."
  git clone https://github.com/rajgoel/reveal.js-plugins.git tmp-plugins
  mv tmp-plugins/* plugins/

  # rm -rf tmp-plugins
else
  echo "✔️  seminar directory already exists — skipping clone."
fi


# setup seminar server
if [ ! -d "seminar-server" ]; then
  echo "⬇️  Cloning Reveal.js Seminar server..."
  git clone https://github.com/rajgoel/seminar seminar-server
  cd seminar-server
  npm install
  cd ..
else
  echo "✔️  seminar-server directory already exists — skipping clone."
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


