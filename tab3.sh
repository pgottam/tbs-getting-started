#!/bin/bash
. demo-magic.sh
clear

pe "cd ~/jasonmorgan/spring-petclinic"
git pull
pe "vim src/main/resources/templates/welcome.html"
pe "git add ."
pe "git commit -m 'lets get a better image'"
pe "git push"
wait
exit
