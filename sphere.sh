#!/bin/bash

NINJA_SERIAL=$2

start() {
	if [[ $NINJA_SERIAL == "" ]]; then
		if [ -f volume-data/sphere-serial.conf ]; then
			NINJA_SERIAL=$(cat volume-data/sphere-serial.conf)
		fi
	fi

	if [[ $NINJA_SERIAL == "" ]]; then
		echo "Serial number must be specified the first time: $0 start <serial>"
		exit 1
	fi

	mkdir -p volume-data
	echo -n "$NINJA_SERIAL" > volume-data/sphere-serial.conf

	docker run -d -it \
		-v $(pwd)/volume-data:/data \
		--env NINJA_SERIAL=$NINJA_SERIAL \
		--name=ninjasphere \
		-p 1883:1883 -p 8000:8000 \
		theojulienne/ninjasphere

	echo 'Sphere service launched.'
}

stop() {
	docker kill ninjasphere
	docker rm ninjasphere
}

ps() {
	docker exec ninjasphere ps aux
}

interact() {
	docker exec -it ninjasphere bash
}

logs() {
	docker $@ ninjasphere
}

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	ps)
		ps
		;;
	shell)
		interact
		;;
	logs)
		logs $@
		;;
	*)
		echo "Usage: $0 start [serial]  -- start the sphere stack, serial must be specified the first time"
	    echo "       $0 stop            -- stop the sphere stack"
	    echo "       $0 ps              -- 'ps aux' inside the container"
	    echo "       $0 shell           -- 'bash' inside the container"
	    echo "       $0 logs [-f]       -- show (or follow) the logs"
	    exit 1
esac

