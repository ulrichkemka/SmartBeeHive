# SmartBeeHive frontend WebApp

This is the directory for the frontend tier of the **SmartBeeHive** platform.
It is intended to work with the backend Spring Boot located [here](../backend/).


## Lien de la maquette:

La maquette de l'application Web se trouve [ici sur figma](https://www.figma.com/proto/nqPtjTzMxzyeOE1QpADcKk/Ruche-connect%C3%A9e?type=design&t=dIB23tM92vO8ogZ8-1&scaling=min-zoom&page-id=0%3A1&starting-point-node-id=2%3A39&show-proto-sidebar=1&node-id=2-39&mode=design) conçue par [Ulrich KEMKA TAKENGNY](https://gitlab.com/ulrichkt2)

## Project structure

Cette partie contient l'application web du projet. Cette application est développée avec le framework [ReactJS](https://create-react-app.dev/)

The project is a React single page app, and it uses the [Vite.js](https://vitejs.dev/) framework to build the application and serve it during development.

- source code is in the [src](./src) directory, with the main script in [main.tsx](./src/main.tsx) and [index.html](./index.html) file.
- dependencies and project configuration is in [package.json](./package.json)
- environment settings for local or production are set in [env.development](./.env.development) and [env.production](./.env.production)

## Required tools

- In order to build and run the project, you will need to install a recent version of [Node.js](https://nodejs.org/en/), which comes with `npm`. Install the latest stable release from their webpage.


## Installing the application

Dependencies for the project should be installed with `npm`. In the root directory of the frontend project, run

```bash
npm install
```

This will install the required libraries in the `node_modules` directory.

## Running the application in development

To start a development web server and serve the application, run

```bash
npm run dev
```

This will start a server listening on port `3000` and open a new browser at this adress.

## Building the application for production

To build the application for production, run

```bash
npm run build
```

This will optimize the application's code and bundle it in a directory called `dist`.

You can preview this built application by running the `npm run preview` command.