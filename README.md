# ninjasphere-docker

Runs a small, self-contained and definitely subtly-different-to-a-real-sphere copy of the Ninja Sphere client services.

Currently only runs on x86_64 Docker, and natively supports boot2docker.

## Getting Started

You'll need docker set up and ready to go. Start by running:
```
./sphere.sh start <serial number>
```

Subsequent ```start``` calls don't need the serial number, it's saved. Pair the Sphere here: http://api.sphere.ninja/ Note that the IP shown after pairing and the link won't work, but you can verify from the logs that it's paired.

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
..../ninjasphere-docker/sphere.sh run-driver ./driver-awesome [extra driver arguments]
```

## Complete Driver Example

A more complete example of getting an entire Go driver into your local Go sources and running it:
```
go get github.com/ninjasphere/driver-go-chromecast
cd $GOPATH/src/github.com/ninjasphere/driver-go-chromecast
go build
..../ninjasphere-docker/sphere.sh run-driver ./driver-go-chromecast
```

## Data Persistance

All "user data" will be stored in ```volume-data``` in the current directory - to start fresh, delete this directory. The serial number will be cached across multiple runs, but it's also stored in this directory to make complete resets easier.

## Exposed Services

Ports 1883 (MQTT) and 8000 (HomeCloud REST) are exposed from the container (and the sphere.sh script publishes them for you too).

REST services can be accessed at for example:
```http://your_docker_host_ip:8000/rest/v1/things```

MQTT can be sniffed using the mosquitto client tools (available as part of homebrew's mosquitto install and ```mosquitto-clients``` on Ubuntu):
```mosquitto_sub -t '#' -v -h your_docker_host_ip```

## Missing Services & Errata

 * Drivers are not included, and homecloud will mutter a bit about them being restarted
 * Sphere Director (the driver/process manager) is not yet installed

## Building

At the time of writing, some of the repositories used to build this are still private, so external users won't be able to build a new copy of the docker image. Once the repositories are public I'll update the scripts so they work without GitHub authentication.