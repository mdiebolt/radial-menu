# Development Workflow

    npm run serve

This starts a server at `localhost:8000`. Watchify will compile `main.coffee` in the site directory into `build.js` which has all its dependencies resolved and is ready to Run in the browser. Jade will watch and pick up changes to .jade files.

When you're ready to deploy a new version of the library run

    bin/release 1.0.x

to update the SemVar version and push out the built library to bower and npm.

After you've pushed up the changes run

    bin/publish

to publish the contents of the `site/` directory to GitHub pages.
