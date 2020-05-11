#!/bin/bash
. demo-magic.sh
clear

pe "cd ~/jasonmorgan/spring-petclinic"
pe "vim src/main/resources/templates/welcome.html"
pe "git add ."
pe "git commit -m 'lets get a better image'"
pe "exit"
