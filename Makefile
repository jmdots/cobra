.PHONY: build
build: test
	go build
	diff -u <(echo -n) <(gofmt -d -s .)
	if [ -z ${NOVET} ]; then diff -u <(echo -n) <(go tool vet . 2>&1 | grep -vE 'ExampleCommand|bash_completions.*Fprint'); fi

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
	go mod vendor
