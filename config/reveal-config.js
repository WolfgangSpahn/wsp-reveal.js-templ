// Variable tracking whether slide deck is connected to seminar server
var isConnected = false;

// Wait for plugins to load before initializing
function initializeReveal() {

// Set page title
document.title = "Reveal.js Presentation";

// Set PDF link
var pdfLink = document.getElementById('pdf-link');
if (pdfLink) {
    pdfLink.href = window.location.href + '?print-pdf';
}

// Full list of configuration options available at:
// https://github.com/hakimel/reveal.js#configuration
Reveal.initialize({
    width: 1280,
    height: 1050,
    controls: true,
    navigationMode: 'linear',
    progress: true,
    history: false,
    center: true,
    mouseWheel: true,
    previewLinks: false,
    slideNumber: true,
    transition: 'slide', // none/fade/slide/convex/concave/zoom
    
    menu: {
        themes: false,
        transitions: false,
        markers: true,
        hideMissingTitles: true,
        custom: [
            { title: 'Broadcast', icon: '<i class="fas fa-rss">', content: getSeminarMenu() }
        ]
    },
    
    animate: {
        autoplay: true
    },
    
    anything: [
        {
            className: "flipofacoin",
            initialize: (function(container, options) {
                container.innerHTML = Math.random() < 0.5 ? "heads" : "tails";
            })
        },
        {
            className: "rollofadie",
            initialize: rollofadie
        },
        {
            className: "randomnumber",
            defaults: { min: 0, max: 9 },
            initialize: (function(container, options) { 
                container.innerHTML = Math.trunc(options.min + Math.random() * (options.max - options.min + 1)); 
            })
        },
        {
            className: "anything",
            initialize: (function(container, options) { 
                if (options && typeof options.initialize === "function") { 
                    options.initialize(container);
                } 
            })
        }
    ],
    
    audio: {
        defaultDuration: 5,
        playerStyle: "position: fixed; bottom: 4px; left: 30%; width: 40%; height:70px; z-index: 33;",
        playerOpacity: 0.5,
        advance: 500,
        prefix: "playback/",
        suffix: '.ogg'
    },
    
    chalkboard: {
        storage: document.title,
        src: "playback/chalkboard.json",
        theme: "blackboard"
        //theme: "whiteboard"
    },
    
    chart: {
        defaults: {
            maintainAspectRatio: false,
            responsive: true,
            color: 'lightgray', // color of labels
            font: { size: 30 },
            scale: {
                beginAtZero: true,
                ticks: { stepSize: 1 },
                grid: { color: 'lightgray' } // color of grid lines
            }
        },
        bar: { backgroundColor: ['firebrick', 'darkred', 'red'] },
        pie: { backgroundColor: [['black', 'red', 'green', 'yellow']] }
    },
    
    customcontrols: {
        controls: [
            {
                icon: '<i class="fa fa-pen-square"></i>',
                title: 'Toggle chalkboard (B)',
                action: 'RevealChalkboard.toggleChalkboard();'
            },
            {
                icon: '<i class="fa fa-pen"></i>',
                title: 'Toggle notes canvas (C)',
                action: 'RevealChalkboard.toggleNotesCanvas();'
            },
            {
                id: 'toggle-questions',
                title: 'Toggle Q&A dashboard (Q)',
                icon: '<span class="fa-stack" style="margin: -24px -12px;padding:0;"><span class="fa-solid fa-comment fa-stack-1x"></span><strong class="fa-stack-1x fa-inverse qna question-counter" style="font-size:0.5em;"></strong></span>',
                action: 'RevealQnA.toggleQnA();'
            }
        ]
    },
    
    seminar: {
        server: 'http://localhost:4433', // change server as necessary
        room: document.title, // put your room name here
        // using room-1, generate hash http://localhost:4433/
        hash: '$2a$05$FJwE..bGLyBzcoAezxAR/OdCRPskkXfPx2SYI9RMrTZYSZHa6JHJ2', // a hash is required for every seminar room and can be generated on the URL of the socket.io server
        autoJoin: false, // set to true to automatically join the seminar room
        logger: seminarStatusLogger
    },
    
    plugins: [
        RevealMarkdown,
        RevealMenu,
        RevealMath,
        RevealHighlight,
        // RevealLoadContent,
        // RevealAnimate,
        // RevealAudioSlideshow,
        // RevealAudioRecorder,
        RevealAnything,
        RevealChalkboard,
        RevealChart,
        RevealCustomControls,
        RevealFullscreen,
        RevealSeminar,
        RevealPoll,
        RevealQnA
    ]
}).then(() => {
// decorate inline MathJax elements with class 'math' allowing to change style
    var inlineMathCode = document.querySelectorAll('.MathJax');
    for (var i=0; i < inlineMathCode.length; i++) {
        inlineMathCode[i].classList.add('math');
    }

if ( !isConnected ) {
    // hide all elements that 
    var showOnConnected = document.querySelectorAll(".seminar.connected") || [];
    for (var i=0; i < showOnConnected.length; i++) {
    showOnConnected[i].style.display = 'none';
    }
}

});

// Initialize Seminar Menu
initSeminarMenu();

} // End of initializeReveal function

// Wait for plugins to be ready before initializing Reveal
if (window.pluginsLoaded) {
    initializeReveal();
} else {
    window.addEventListener('pluginsReady', initializeReveal);
}
