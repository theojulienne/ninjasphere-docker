all: client director homecloud mqtt-bridgeify build

build: sphere-config sphere-schemas
	docker build -t theojulienne/ninjasphere .

sphere-config:
	git clone https://github.com/ninjasphere/sphere-config.git

sphere-schemas:
	git clone https://github.com/ninjasphere/schemas.git sphere-schemas

client:
	bash build-binary.sh ninjasphere/sphere-client

director:
	bash build-binary.sh ninjasphere/sphere-director

homecloud:
	bash build-binary.sh ninjasphere/sphere-go-homecloud

mqtt-bridgeify:
	bash build-binary.sh ninjablocks/mqtt-bridgeify