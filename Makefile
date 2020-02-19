# Copyright 2019 The Kubernetes Authors.
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

CMDS=lvmplugin
all: provisioner

.PHONY: provisioner
provisioner:
	go build -tags netgo -o bin/csi-lvmplugin-provisioner cmd/provisioner/*.go
	strip bin/csi-lvmplugin-provisioner

.PHONY: dockerimages
dockerimages:
	docker build -t mwennrich/lvmplugin:latest . 
	docker build -t mwennrich/csi-lvmplugin-provisioner:latest . -f cmd/provisioner/Dockerfile

.PHONY: dockerpush
dockerpush:
	docker push mwennrich/lvmplugin:latest 
	docker push mwennrich/csi-lvmplugin-provisioner:latest 

