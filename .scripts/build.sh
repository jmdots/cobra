#!/usr/bin/env bash

set -xeuo pipefail

go build -mod=vendor

diff -u <(echo -n) <(gofmt -d -s .)

if [ -z ${NOVET} ]; then
  diff -u <(echo -n) <(go tool vet . 2>&1 | grep -vE 'ExampleCommand|bash_completions.*Fprint')
fi
