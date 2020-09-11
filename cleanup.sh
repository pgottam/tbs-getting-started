#!/bin/sh

ytt -f /tmp/values.yaml \
    -f /tmp/manifests/ \
    -v docker_repository="your-docker-repo" \
    -v docker_username="your-docker-username" \
    -v docker_password='your-docker-password' \
    | kbld -f /tmp/images-relocated.lock -f- \
    | kapp delete -a tanzu-build-service -y

kubens default