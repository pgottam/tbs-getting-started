#!/bin/bash

## Check on the StorageClass
`k get sc`
`k apply -f .priv/storage-class-aws.yml`

## Install duffle
curl -Lo duffle https://github.com/cnabio/duffle/releases/download/0.3.5-beta.1/duffle-$(uname)-amd64
chmod +x ./duffle
sudo mv duffle /usr/local/bin/

## Duffle Relocate
# We now use duffle to unpack the archive and move the images into our registry
docker login IMAGE-REGISTRY # This is where we login to whatever our target registry is

duffle relocate -f /tmp/build-service-${version}.tgz -m /tmp/relocated.json -p IMAGE-REGISTRY


# /mnt/c/Users/jmorg/
duffle install BUILD-SERVICE-INSTALLATION-NAME -c /tmp/credentials.yml  \
    --set kubernetes_env=CLUSTER-NAME \
    --set docker_registry=DOCKER-REGISTRY \
    --set docker_repository=DOCKER-REPOSITORY \
    --set registry_username="REGISTRY-USERNAME" \
    --set registry_password="REGISTRY-PASSWORD" \
    --set custom_builder_image="BUILDER-IMAGE-TAG" \
    -f /tmp/build-service-${version}.tgz \
    -m /tmp/relocated.json

## Start messing with TBS

pb stack status
pb store list
pb builer list
