#!/bin/bash
. demo-magic.sh
clear

pe "watch kp build list petclinic"
clear
pe "watch kubectl get pods -l app=petclinic"
clear
pe "watch kp build list petclinic"
clear
pe "watch kubectl get pods -l app=petclinic"
clear
pe "watch kp build list petclinic"
clear
pe "watch 'kubectl get builds -o custom-columns=IMAGE:\"metadata.labels.image\.kpack\.io/image\",\"REASON\":\"metadata.annotations.image\.kpack\.io/reason\",STATUS:status.conditions[0].type,NAME:.metadata.name | grep STACK' "
clear