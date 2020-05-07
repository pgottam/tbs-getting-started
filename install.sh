#!/bin/bash
# /mnt/c/Users/jmorg/
duffle install 59s-build-service -c /tmp/credentials.yml \
  --set kubernetes_env=prod1 \
  --set docker_registry=index.docker.io \
  --set registry_username="USERNAME" \ # Valid Registry Username
  --set registry_password='PASSWORD' \ # Valid registry password
  --set custom_builder_image="index.docker.io/jasonmorgan/default-builder" \ # Where do you want the builder published to
  -f /mnt/c/Users/jmorg/temp/build-service-0.1.0.tgz \
  -m /tmp/relocated.json
