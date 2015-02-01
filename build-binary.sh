
REPO=$1
DIR=$(basename $REPO)

if [ ! -d $DIR ]; then
	git clone git@github.com:${REPO}.git $DIR
fi

pushd $DIR
git pull
popd

PLATFORMS="linux/amd64"

for PLATFORM in $PLATFORMS; do
	export GOOS=${PLATFORM%/*}
	export GOARCH=${PLATFORM#*/}

	pushd $DIR
	./scripts/build.sh
	popd
	mkdir -p bin-$GOOS-$GOARCH
	cp $DIR/bin/* bin-$GOOS-$GOARCH/
done

