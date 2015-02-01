# ninjasphere-docker

Runs a small, self-contained and definitely subtly-different-to-a-real-sphere copy of the Ninja Sphere client services.

Currently only runs on x86_64 Docker, and natively supports boot2docker.

## Getting Started

You'll need docker set up and ready to go. Start by running:
```
./sphere.sh start
```

To get a list of supported commands (they are just simple convenience wrappers around docker):
```
./sphere.sh
```

Most usefully:
```
./sphere.sh logs -f
```

And the convenient wrapper to run a Go driver pointing at the docker instance:
```
...../ninjasphere-docker/docker/sphere.sh run-driver ./bin/driver-go-lifx [any additional arguments to the driver]
```

## Data Persistance

All "user data" will be stored in ```volume-data``` in the current directory - to start fresh, delete this directory. The serial number will be cached across multiple runs, but it's also stored in this directory to make complete resets easier.

## Exposed Services

Ports 1883 (MQTT) and 8000 (HomeCloud REST) are exposed from the container (and the sphere.sh script publishes them for you too).

## Missing Services & Errata

 * Drivers are not included, and homecloud will mutter a bit about them being restarted
 * Sphere Director (the driver/process manager) is not yet installed

## Building

At the time of writing, some of the repositories used to build this are still private, so external users won't be able to build a new copy of the docker image. Once the repositories are public I'll update the scripts so they work without GitHub authentication.