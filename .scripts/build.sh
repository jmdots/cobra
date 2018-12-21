#!/usr/bin/env bash

set -xeuo pipefail

go build -mod=vendor .

## Build the CLI tool.
mkdir -p ./tmp
go build -o tmp/cobra -mod=vendor ./cobra

## Try running the CLI tool.
./tmp/cobra
