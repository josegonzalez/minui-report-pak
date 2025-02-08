TAG ?= latest
BUILD_DATE := "$(shell date -u +%FT%TZ)"
PAK_NAME := $(shell jq -r .label config.json)
COREUTILS_VERSION := 0.0.28

clean:
	rm -rf bin/evtest || true
	rm -f bin/sdl2imgshow || true
	rm -f bin/coreutils || true
	rm -f bin/coreutils.LICENSE || true
	rm -f res/fonts/BPreplayBold.otf || true

build: bin/evtest bin/sdl2imgshow bin/coreutils res/fonts/BPreplayBold.otf

bin/evtest:
	docker buildx build --platform linux/arm64 --load -f Dockerfile.evtest --progress plain -t app/evtest:$(TAG) .
	docker container create --name extract app/evtest:$(TAG)
	docker container cp extract:/go/src/github.com/freedesktop/evtest/evtest bin/evtest
	docker container rm extract
	chmod +x bin/evtest

bin/sdl2imgshow:
	docker buildx build --platform linux/arm64 --load -f Dockerfile.sdl2imgshow --progress plain -t app/sdl2imgshow:$(TAG) .
	docker container create --name extract app/sdl2imgshow:$(TAG)
	docker container cp extract:/go/src/github.com/kloptops/sdl2imgshow/build/sdl2imgshow bin/sdl2imgshow
	docker container rm extract
	chmod +x bin/sdl2imgshow

bin/coreutils:
	curl -sSL -o bin/coreutils.tar.gz "https://github.com/uutils/coreutils/releases/download/$(COREUTILS_VERSION)/coreutils-$(COREUTILS_VERSION)-aarch64-unknown-linux-gnu.tar.gz"
	tar -xzf bin/coreutils.tar.gz -C bin --strip-components=1
	rm bin/coreutils.tar.gz
	chmod +x bin/coreutils
	mv bin/LICENSE bin/coreutils.LICENSE
	rm bin/README.md bin/README.package.md || true

res/fonts/BPreplayBold.otf:
	mkdir -p res/fonts
	curl -sSL -o res/fonts/BPreplayBold.otf "https://raw.githubusercontent.com/shauninman/MinUI/refs/heads/main/skeleton/SYSTEM/res/BPreplayBold-unhinted.otf"

release: build
	mkdir -p dist
	git archive --format=zip --output "dist/$(PAK_NAME).pak.zip" HEAD
	while IFS= read -r file; do zip -r "dist/$(PAK_NAME).pak.zip" "$$file"; done < .gitarchiveinclude
	ls -lah dist
