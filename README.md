# Django Dockyard

A Docker wrapper for Django contributions.

## Usage

Clone this repo, then clone your `django` fork into it:

```sh
$ git clone git@github.com:<USERNAME>/django.git
```

Run the containers:

```sh
$ docker compose up
```

Happy development!

## Testing

Run the test suite:

```sh
$ cd django
$ make test
```

> A custom settings module located at `settings/test_local.py` is passed by default.
