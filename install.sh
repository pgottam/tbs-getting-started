#!/bin/bash

## Check on the StorageClass
# `k get sc`
# `k apply -f .priv/storage-class-aws.yml`

docker login registry.pivotal.io

kbld relocate -f /tmp/images.lock --lock-output /tmp/images-relocated.lock --repository <your-repository>

ytt -f /tmp/values.yaml \
    -f /tmp/manifests/ \
    -v docker_repository="your-docker-repo" \
    -v docker_username="your-docker-username" \
    -v docker_password='your-docker-password' \
    | kbld -f /tmp/images-relocated.lock -f- \
    | kapp deploy -a tanzu-build-service -f- -y

kp import -f .priv/descriptor-7.yaml

