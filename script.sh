#!/bin/bash

## Assumes TBS is installed and ready to be configured

vim image.yaml

pb image apply -f image.yaml
pb image logs index.docker.io/jasonmorgan/pbpetclinic -b 1 -f
## pb image build index.docker.io/jasonmorgan/pbpetclinic -b 1
## pb image trigger index.docker.io/jasonmorgan/pbpetclinic

pb image logs index.docker.io/jasonmorgan/pbpetclinic -b 2 -f
pb image build index.docker.io/jasonmorgan/pbpetclinic -b 2
watch pb image builds index.docker.io/jasonmorgan/pbpetclinic

## New tab
watch pb image builds index.docker.io/jasonmorgan/pbpetclinic

docker pull jasonmorgan/pbpetclinic
docker run -it --rm -p 8080:8080 jasonmorgan/pbpetclinic
docker inspect jasonmorgan/pbpetclinic | less

docker inspect jasonmorgan/pbpetclinic | jq '.[].Config.Labels."io.buildpacks.project.metadata" | fromjson'


docker inspect jasonmorgan/pbpetclinic | jq '.[].Config.Labels."io.buildpacks.lifecycle.metadata" | fromjson'

docker inspect jasonmorgan/pbpetclinic | jq '.[].Config.Labels."io.buildpacks.lifecycle.metadata" | fromjson | .buildpacks'

## Change to tonka
## Commit

pb image logs index.docker.io/jasonmorgan/pbpetclinic -b 3 -f

## New tab

docker run -it --rm -p 8080:8080 jasonmorgan/pbpetclinic

## STACK Update

pb stack update --build-image registry.pivotal.io/tbs-dependencies/build:1586272925 --run-image registry.pivotal.io/tbs-dependencies/run:1586272925
watch pb image builds index.docker.io/techgnosis/mysql
pb image logs index.docker.io/techgnosis/mysql -b 4 -f

### Old stuff

pb image trigger index.docker.io/jasonmorgan/pbpetclinic:latest
pb image logs index.docker.io/jasonmorgan/pbpetclinic:latest -b 4 -f
docker pull jasonmorgan/pbpetclinic
docker inspect jasonmorgan/pbpetclinic | less

## jq examples
docker inspect jasonmorgan/pbpetclinic | jq '.[].Config.Labels."io.buildpacks.lifecycle.metadata" | fromjson'

docker inspect jasonmorgan/pbpetclinic | jq '.[].Config.Labels."io.buildpacks.lifecycle.metadata" | fromjson | .buildpacks'

## Run 
  
