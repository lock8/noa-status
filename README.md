# noa-status

Noa service status page.

### Install
You'll need to get [Elm][elm] and [npm][npm] installed.

Get the dependencies installed:

    $ npm install && elm package install

### Development
Fire up a local server (hot swap/watch baked in) at [localhost:8080/][localhost] with:

    $ npm start

### Deploy
Get the build ready for production by running:

    $ npm run build

Then, push to the `gh-pages` branch with:

    $ git subtree push --prefix dist upstream gh-pages

[elm]: http://elm-lang.org/
[npm]: https://www.npmjs.com/
[localhost]: http://localhost:8080/
[elm-starter]: https://github.com/moarwick/elm-webpack-starter
