TAG ?= latest
BUILD_DATE := "$(shell date -u +%FT%TZ)"
PAK_NAME := $(shell jq -r .label config.json)

PLATFORMS := rg35xxplus tg5040
ARCHITECTURES := arm64

COREUTILS_VERSION := 0.0.28
EVTEST_VERSION := 0.1.0
MINUI_PRESENTER_VERSION := 0.4.0

clean:
	rm -f bin/*/evtest || true
	rm -f bin/*/coreutils || true
	rm -f bin/*/minui-presenter || true

build: $(foreach platform,$(PLATFORMS),bin/$(platform)/minui-presenter) $(foreach arch,$(ARCHITECTURES),bin/$(arch)/evtest bin/$(arch)/coreutils)

bin/%/evtest:
	mkdir -p bin/$*
	curl -sSL -o bin/$*/evtest https://github.com/josegonzalez/compiled-evtest/releases/download/$(EVTEST_VERSION)/evtest-$*
	curl -sSL -o bin/$*/evtest.LICENSE "https://raw.githubusercontent.com/freedesktop-unofficial-mirror/evtest/refs/heads/master/COPYING"
	chmod +x bin/$*/evtest

bin/%/minui-presenter:
	mkdir -p bin/$*
	curl -sSL -o bin/$*/minui-presenter https://github.com/josegonzalez/minui-presenter/releases/download/$(MINUI_PRESENTER_VERSION)/minui-presenter-$*
	chmod +x bin/$*/minui-presenter

bin/arm64/coreutils:
	mkdir -p bin/arm64
	curl -sSL -o bin/arm64/coreutils.tar.gz "https://github.com/uutils/coreutils/releases/download/$(COREUTILS_VERSION)/coreutils-$(COREUTILS_VERSION)-aarch64-unknown-linux-gnu.tar.gz"
	tar -xzf bin/arm64/coreutils.tar.gz -C bin/arm64 --strip-components=1
	rm bin/arm64/coreutils.tar.gz
	chmod +x bin/arm64/coreutils
	mv bin/arm64/LICENSE bin/arm64/coreutils.LICENSE
	rm bin/arm64/README.md bin/arm64/README.package.md || true

release: build
	mkdir -p dist
	git archive --format=zip --output "dist/$(PAK_NAME).pak.zip" HEAD
	while IFS= read -r file; do zip -r "dist/$(PAK_NAME).pak.zip" "$$file"; done < .gitarchiveinclude
	ls -lah dist
