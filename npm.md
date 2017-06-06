# NPM 101

Bullet points that will help you get started with npm :metal:.

+ `npm -v` prints the version of npm installed on your machine
+ The latest version at the time of writing is `5.0.2`
+ Update npm on your osx machine with `$ npm i -g npm`
+ Always init a new project with `npm init`
+ `npm init` will interactively create a package.json for your project. 
+ `npm init --yes` skips the interactive mode and just create a package.json.
+ Lock down dependency versions for publication with `npm shrinkwrap`
+ Set default config with `npm config` (see below)
+ Use .npmrc file for setting project config (see below)
+ Use lifecycle scripts like `npm start`, `npm test`, `npm build`, `npm deploy`
+ Always save when installing module 
+ Understand the difference between dependencies vs dev-dependencies (see below)
+ Remove dev-dependencies before deploying to production
+ Lastly, don't commit your node_modules


## Set default config with `npm config`

Set a default author name and email so that you don't need to fill them when you run `npm init`.

```bash
$ npm config set init.author.name=YOUR_NAME
$ npm config set init.author.email=YOUR_EMAIL
$ npm config set init.author.url=YOUR_URL

# View available commands
$ npm config

# View the configs you set
$ npm config list

# View all options
$ npm config edit
```



## Use .npmrc for setting project config

In `.npmrc` file in your project directory:

```npmrc
save=true
save-exact=true
```

This will ensure the exact package version is installed and `--save` command is invoked when npm install is run. Note that in npm version 5.0.2 the dependencies will be saved by default.

## Lifecycle scripts

Maximize the use of lifecycle scripts - type less.

In `package.json`:
```json
"scripts": {
    "start": "node index.js",
    "test": "YOUR TEST SCRIPTS"
}
```

With this, you can just run `npm start` instead of typing `node index.js`. Useful when the commands gets longer.

## dependencies vs dev-dependencies

A module installed using `-save` or `-S` flags is saved as `dependencies` in your package.json. Your nodejs app is dependent on it - it will not work without this dependencies installed.

A module installed using `-save-dev` or `-D` flags is saved as `dev-depedencies` in your package.json. Your nodejs app is not dependent on it, but your development environment is dependent on it.

Testing/mocking libraries such as `mocha`, `nock` will be in dev-dependencies. Since your app does not depend on them, it should be excluded when you deploy to production.

## Remove dev-dependencies before deploying to production

`npm prune --production` will remove node_modules specified in the dev-dependencies.

## Don't commit your node_modules

If you have accidentally committed your node modules, you can remove it like this:
```bash
$ echo 'node_modules' >> .gitignore
$ echo 'npm-debug.log' >> .gitignore

$ git rm -r --cached node_modules
$ git commit -am 'ignore node_modules'
```
