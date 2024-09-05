# converge

This is a project written using [Lucky](https://luckyframework.org). Enjoy!

### Converge API

Example request to: `http://localhost:3000/api/events`

```
{
  "name": "Test Event 2",
  "host_name": "Mr Host",
  "slots": [
    {"slot_type": "DAY", "slot_start": "2024-09-06T14:00:00.000Z"},
    {"slot_type": "DAY", "slot_start": "2024-09-07T14:00:00.000Z"},
    {"slot_type": "DAY", "slot_start": "2024-09-08T14:00:00.000Z"}
  ]
}
```

This will create an event with the data given in this request.
I've yet to add GET for the event, or to create an endpoint for people to register their repsonses, but
now that I have a handle on how to use Serializers, Operations and Actions I think this shouldn't be too bad to create.

I'm mostly saving this payload here in the README as a reminder of how to POST to the endpoint.

### Setting up the project

1. [Install required dependencies](https://luckyframework.org/guides/getting-started/installing#install-required-dependencies)
1. Update database settings in `config/database.cr`
1. Run `script/setup`
1. Run `lucky dev` to start the app

### Using Docker for development

1. [Install Docker](https://docs.docker.com/engine/install/)
1. Run `docker compose up`

The Docker container will boot all of the necessary components needed to run your Lucky application.
To configure the container, update the `docker-compose.yml` file, and the `docker/development.dockerfile` file.


### Learning Lucky

Lucky uses the [Crystal](https://crystal-lang.org) programming language. You can learn about Lucky from the [Lucky Guides](https://luckyframework.org/guides/getting-started/why-lucky).
