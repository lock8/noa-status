# noa-status

Noa service status page.

### install
You'll need to get [Elm][elm] and [npm][npm] installed.

Get the dependencies installed:

    $ npm install && elm package install

### development
Fire up a local server (hot swap/watch baked in) at [http://localhost:8080/][localhost] with:

    $ npm start

The build is powered by the awesome [elm-webpack-starter][elm-starter].

### deploy
Get the build ready for production by running:

    $ npm run build

Files are saved into `/dist` which is a git repository on the `gh-pages` branch.


[elm]: http://elm-lang.org/
[npm]: https://www.npmjs.com/
[localhost]: http://localhost:8080/
[elm-starter]: https://github.com/moarwick/elm-webpack-starter
