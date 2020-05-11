#!/bin/bash
. demo-magic.sh
clear
## Assumes TBS is installed and ready to be configured

pe "pb stack status"
pe "kubectl get stack --all-namespaces"
wait
clear

pe "pb store list"
wait
clear
pe "kubectl get store --all-namespaces"
wait
clear

pe "pb builder list"
pe "kubectl get CustomClusterBuilder,CustomBuilder --all-namespaces"
wait
clear

pe "pb project create 59s-prod"
pe "pb project list"
pe "kubectl get project"
pe "pb project target 59s-prod"
wait
clear

pe "pb secrets registry apply -f .priv/reg-creds.yaml"
pe "vim registry-creds.yaml"
clear

pe "vim image.yaml"
wait
clear

pe "pb image apply -f image.yaml"

### Doesn't stream output Need to fix
pe "pb image logs index.docker.io/jasonmorgan/pbpetclinic -b 1 -f"
wait
clear

pe "pb image build index.docker.io/jasonmorgan/pbpetclinic -b 1"
wait
clear


pe "docker pull jasonmorgan/pbpetclinic"
pe "docker run -it --rm -p 8080:8080 jasonmorgan/pbpetclinic"
pe "docker inspect jasonmorgan/pbpetclinic | less"
wait
clear


pe "docker inspect jasonmorgan/pbpetclinic | jq '.[].Config.Labels.\"io.buildpacks.project.metadata\" | fromjson'"
wait
clear


pe "docker inspect jasonmorgan/pbpetclinic | jq '.[].Config.Labels.\"io.buildpacks.lifecycle.metadata\" | fromjson | .buildpacks'"
wait
clear


## New tab

## Change to tonka in other tab

## Commit

pe "pb image logs index.docker.io/jasonmorgan/pbpetclinic -b 2 -f"

## New tab

pe "docker pull jasonmorgan/pbpetclinic"
pe "docker run -it --rm -p 8080:8080 jasonmorgan/pbpetclinic"

## STACK Update

## Go find the latest run and build images
### Browse to https://registry.pivotal.io
### Go pull the latest image for registry.pivotal.io/tbs-dependencies/run and registry.pivotal.io/tbs-dependencies/build
#### Ex:
# docker pull registry.pivotal.io/tbs-dependencies/run:1586272925
# docker pull registry.pivotal.io/tbs-dependencies/build:1586272925


pe "pb stack update --build-image registry.pivotal.io/tbs-dependencies/build:1586272925 --run-image registry.pivotal.io/tbs-dependencies/run:1586272925"
pe "pb image logs index.docker.io/jasonmorgan/pbpetclinic -b 3 -f"

### Trigger Build

pe "pb image trigger index.docker.io/jasonmorgan/pbpetclinic:latest"
pe "pb image logs index.docker.io/jasonmorgan/pbpetclinic:latest -b 4 -f"
  
