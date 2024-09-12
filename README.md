# converge

This is the code for converge. An app that aims to make it easier to work out what days people are free.

This app is built with the Lucky Framework for the Crystal programming language.
The frontend is written in Typescript + Vue3

### Local Development

For local development you'll have to change API_BASE and LINK_BASE to:

```
const API_BASE = "http://localhost:3000"
```

and:

```
const LINK_BASE = "http://localhost:5173/?event_uuid=";
```

### Setting up the backend 

1. [Install required dependencies](https://luckyframework.org/guides/getting-started/installing#install-required-dependencies)
1. Update database settings in `config/database.cr`
1. Run `script/setup`
1. Run `lucky dev` to start the app

### Using Docker for development

1. [Install Docker](https://docs.docker.com/engine/install/)
1. Run `docker compose up`

The Docker container will boot all of the necessary components needed to run your Lucky application.
To configure the container, update the `docker-compose.yml` file, and the `docker/development.dockerfile` file.

### Setting up the frontend

```
cd frontend
npm install
npm run dev
```

### Learning Lucky

Lucky uses the [Crystal](https://crystal-lang.org) programming language. You can learn about Lucky from the [Lucky Guides](https://luckyframework.org/guides/getting-started/why-lucky).

### Deployment

I am mostly writing this down in case I have to change servers at some point.

Deploys are via dokku, to deploy this app:

First locally (or in Docker with lucky setup) run:

```
lucky gen.secret_key
```

On server:

```
dokku apps:create converge-api.<domain.tld>
sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git
dokku postgres:create converge
dokku postgres:link converge converge-api.<domain.tld>
dokku config:set converge-api.<domain.tld> LUCKY_ENV=production
dokku config:set converge-api.<domain.tld> APP_DOMAIN=converge-api.<domain.tld>
dokku config:set converge-api.<domain.tld> PORT=5000
dokku postgres:info converge 
dokku config:set converge-api.<domain.tld> DATABASE_URL=<dsn_from_above_command>
dokku config:set converge-api.<domain.tld> SECRET_KEY_BASE=<secret_key_from_local>
dokku config:set converge-api.<domain.tld> SEND_GRID_KEY=unused
```

On local:

```
git remote add dokku dokku@SERVER_IP:converge-api.<domain.tld>
git push dokku main
```

And the app should get deployed!
Follow the dokku docs to enable lets encrypt as well for https!
