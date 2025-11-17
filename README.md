# Reveal.js Seminar Template


This is a Reveal.js template that includes the [Reveal.js Seminar Plugin](https://github.com/rajgoel/reveal.js-seminar). It also includes the Poll, Chalkboard, Question and Chart plugins.


## Interactive Setup

To use this template interactively, you need to start the seminar server. 

~~~bash
cd seminar-server
npm start
~~~

When server is running note you socker nr, load following URL in your browser, enter a password and click on "Generate Hash":

~~~bash
http://localhost:4433/

Seminar socket.io platform

Enter password: seminar-password

Repeat password: seminar-password

Rounds:

[Generate Hash]

Hash: 
~~~

-**Attention:** This hash needs to be copied into the `hash` field in `src/index.html` in the seminar configuration section.