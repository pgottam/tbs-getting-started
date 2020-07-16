#!/bin/bash
. demo-magic.sh
clear

pe "watch pb image builds index.docker.io/jasonmorgan/pbpetclinic"
pe "watch kubectl get pods -n default"