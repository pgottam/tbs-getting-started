#!/bin/sh


ytt -f /tmp/values.yaml \
    -f /tmp/manifests/ \
    -v docker_repository="jasonmorgan" \
    -v docker_username="jasonmorgan" \
    -v docker_password='Ja5!T3#jWO9R' \
    | kbld -f /tmp/images-relocated.lock -f- \
    | kapp delete -a tanzu-build-service -y

kubens default