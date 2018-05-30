# Copyright (c) 2015 Rackspace
# Copyright (c) 2016-2018 iQIYI.com.  All rights reserved.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
FALCON_VERSION?=$(shell git describe --tags)

all: bin/falcon

all_debug:
	mkdir -p bin
	go build -o bin/falcon -gcflags='-N -l' -ldflags "-X github.com/iqiyi/falcon/common.Version=$(FALCON_VERSION)" github.com/iqiyi/falcon/cmd/falcon

bin/falcon: */*.go */*/*.go
	mkdir -p bin
	go build -o bin/falcon -ldflags "-X github.com/iqiyi/falcon/common.Version=$(FALCON_VERSION)" github.com/iqiyi/falcon/cmd/falcon

get:
	go get -t $(shell go list ./... | grep -v /vendor/)

fmt:
	gofmt -l -w -s $(shell find . -mindepth 1 -maxdepth 1 -type d -print | grep -v vendor)

test:
	@test -z "$(shell find . -name '*.go' | grep -v ./vendor/ | xargs gofmt -l -s)" || (echo "You need to run 'make fmt'"; exit 1)
	go vet $(shell go list ./... | grep -v /vendor/)
	go test -cover $(shell go list ./... | grep -v /vendor/)

install: bin/falcon
	cp bin/falcon $(DESTDIR)/usr/bin/falcon

develop: bin/falcon
	ln -f -s bin/falcon /usr/local/bin/falcon
