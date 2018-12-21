#!/usr/bin/env bash

set -xeuo pipefail

## Locate all go source files, excluding vendor dir.
gofiles=$(find . -path ./vendor -prune -o -name '*.go' -print)

## Run go test
PATH=${PATH}:${PWD}/bin go test -v .

## Exit non-zero if there are any fmt suggestions.
diff -u <(echo -n) <(gofmt -d -s ${gofiles})

## Exit non-zero if there are any vet suggestions.
if [ ${NOVET:-null} != "null" ]; then
  diff -u <(echo -n) <(go tool vet ${gofiles} 2>&1 | grep -vE 'ExampleCommand|bash_completions.*Fprint')
fi
