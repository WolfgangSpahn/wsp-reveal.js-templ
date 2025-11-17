//
// Unified plugin loader for Reveal.js
//

const pluginsToLoad = [
  // Built-in Reveal plugins
  { type: "script", src: "reveal.js/plugin/markdown/markdown.js" },
  { type: "script", src: "reveal.js/plugin/highlight/highlight.js" },
  { type: "script", src: "reveal.js/plugin/math/math.js" },

  // Vendor libraries
  { type: "script", src: "vendor/socket.io/socket.io.js" },
  { type: "script", src: "vendor/chart.js/chart.min.js" },
  { type: "script", src: "vendor/svg.js/svg.min.js" },
  { type: "style",  href: "vendor/fontawesome/css/all.min.css" },
  { type: "script", src: "vendor/fontawesome/js/all.min.js" },
  { type: "script", src: "https://unpkg.com/qr-code-styling@1.6.0-rc.1/lib/qr-code-styling.js" },

  // Third-party plugins (from reveal.js-plugins)
  { type: "script", src: "plugins/loadcontent/plugin.js" },
  { type: "script", src: "plugins/animate/plugin.js" },
  { type: "script", src: "plugins/audio-slideshow/plugin.js" },
  { type: "script", src: "plugins/audio-slideshow/recorder.js" },
  { type: "script", src: "plugins/anything/plugin.js" },
  
  { type: "style",  href: "plugins/chalkboard/style.css" },
  { type: "script", src: "plugins/chalkboard/plugin.js" },

  { type: "style",  href: "plugins/poll/style.css" },
  { type: "script", src: "plugins/poll/plugin.js" },

  { type: "style",  href: "plugins/questions/style.css" },
  { type: "script", src: "plugins/questions/plugin.js" },

  { type: "style",  href: "plugins/customcontrols/style.css" },
  { type: "script", src: "plugins/customcontrols/plugin.js" },

  { type: "script", src: "plugins/fullscreen/plugin.js" },
  { type: "script", src: "plugins/seminar/plugin.js" },
  { type: "script", src: "plugins/chart/plugin.js" },

  // Menu plugin (should come last)
  { type: "script", src: "plugins/menu/menu.js" }
];


function loadScript(src) {
  return new Promise(resolve => {
    const s = document.createElement('script');
    s.src = src;
    s.onload = resolve;
    document.head.appendChild(s);
  });
}

function loadStylesheet(href) {
  return new Promise(resolve => {
    const l = document.createElement('link');
    l.rel = 'stylesheet';
    l.href = href;
    l.onload = resolve;
    document.head.appendChild(l);
  });
}

async function loadPluginsInOrder() {
  for (const item of pluginsToLoad) {
    if (item.type === "script") {
      await loadScript(item.src);
    } else if (item.type === "style") {
      await loadStylesheet(item.href);
    }
  }
  console.log("All plugins loaded.");
  
  // Signal that plugins are ready
  window.pluginsLoaded = true;
  window.dispatchEvent(new Event('pluginsReady'));
}

// Start loading
loadPluginsInOrder();
