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

^This will create an event with the data given in this request.


Example request to `http://localhost:3000/api/events/<event_uuid>/guest/`

```
{ name: "Guest A" }
```

And now you can also 'GET' an event at: `http://localhost:3000/api/events/<event_uuid>`
and it will include the slots and responses.

To indicate responses to event slots hit: `http://localhost:3000/api/events/<event_uuid>/responses/` with:

```
{
  "guest_id": 4,
  "responses": [
    {"response": "YES", "slot_id": 8},
    {"response": "MAYBE", "slot_id": 9},
    {"response": "NO", "slot_id": 10}
  ]
}
```

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
