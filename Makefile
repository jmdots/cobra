.PHONY: build
build: test
	bash .scripts/build.sh

.PHONY: mod
mod:
	go mod tidy -v
	go mod verify

.PHONY: spellcheck
spellcheck:
	mkdir -p bin
	curl -Lso bin/shellcheck https://github.com/caarlos0/shellcheck-docker/releases/download/v0.4.3/shellcheck
	chmod +x bin/shellcheck

.PHONY: test
test:
	PATH=${PATH}:${PWD}/bin go test -v ./...

.PHONY: vendor
vendor:
	go mod vendor -v
