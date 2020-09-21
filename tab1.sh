#!/bin/bash
. demo-magic.sh
clear

# kp image create go-app --tag rjmo/go-app --git https://github.com/techgnosis/tanzu-golang.git --git-revision master > /dev/null 2>&1 || true

p "Let's start by creating an image. At this point we have TBS installed and docker hub registry credentials configured."
clear

kp image create petclinic --tag rjmo/petclinic --git https://github.com/jasonmorgan/spring-petclinic --git-revision main > /dev/null 2>&1
p "kp image create petclinic --tag rjmo/petclinic --git https://github.com/jasonmorgan/spring-petclinic --git-revision main"
# kp image create petclinic --tag rjmo/petclinic --git https://github.com/jasonmorgan/spring-petclinic --git-revision main > /dev/null 2>&1
wait
echo ""
# clear

p "in the above command we created a new image object in tbs using the imperative kp command line."
echo ""
# clear

p "we named our image petclinic, set the image tag for our image repository, provided the git url, and decided what branch or commit id to build. When using a branch name TBS will always build the latest commit from that branch."
clear

pe "kp build logs petclinic -b 1"
wait
clear

p "Let's deploy our app to k8s"
clear

pe "kubectl apply -f spring-deploy.yaml"
wait
clear

pe "bat -l yaml spring-deploy.yaml"
wait
clear

pe "docker pull rjmo/petclinic"
pe "docker run -it --rm -p 8080:8080 rjmo/petclinic"
wait
clear

## Change to tonka in other tab
p "Let's modify pet clinic in another window. This will cause TBS to rebuild the petclinic image using our later commit ID"
wait
clear

## Commit
## Need to watch for builds

# pe "watch kp build list petclinic"
# clear
pe "kp build logs petclinic -b 2"
wait
clear
p "Now we can update our k8s deployment"
clear
pe "kubectl rollout restart deployment petclinic-deployment -n default"
wait
clear
## New tab

## STACK Update

pe "kp import -f .priv/descriptor-8.yaml"
wait 
clear
# pe "kp import -f .priv/descriptor-9.yaml"
# wait 
# clear
pe "kp build logs petclinic -b 3"
wait 
clear

p "Here we can dive into the additional data provided by Cloud Native Buildpacks and TBS"
clear
pe "docker inspect alpine | bat -l json"
wait
clear
pe "docker inspect rjmo/petclinic |  bat -l json"
wait
clear

pe "docker inspect rjmo/petclinic | jq '.[].Config.Labels.\"io.buildpacks.project.metadata\" | fromjson'"
wait
clear

pe "docker inspect rjmo/petclinic | jq '.[].Config.Labels.\"io.buildpacks.lifecycle.metadata\" | fromjson | .buildpacks'"
wait
clear

pe "pack inspect-image jasonmorgan/petclinic --bom | jq '.' | less"
wait
clear

## We're going to use pack inspect next to checkout the BOM for a given image

