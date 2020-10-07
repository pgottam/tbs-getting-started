#!/bin/bash
. demo-magic.sh
clear

# kp image create go-app --tag jasonmorgan/go-app --git https://github.com/techgnosis/tanzu-golang.git --git-revision master > /dev/null 2>&1 || true

#p "Let's start by creating an image. At this point we have TBS installed and docker hub registry credentials configured."
pe "kp image create petclinic --tag harbor.pgottam-demo.live/demobuild/minions-pc --git https://github.com/pgottam/spring-petclinic.git --git-revision master"
#p "in the above command we created a new image object in tbs using the imperative kp command line."
#p "we named our image petclinic, set the image tag for our image repository, provided the git url, and decided what branch or commit id to build. When using a branch name TBS will always build the latest commit from that branch."
pe "kp build logs petclinic -b 1"
wait
clear

p "Let's deploy our app to k8s"
pe "kubectl apply -f spring-deploy.yaml"
pe "bat -l yaml spring-deploy.yaml"

## pe "docker pull harbor.pgottam-demo.livep/demobuild/minions-pc"
## pe "docker run -it --rm -p 8080:8080 harbor.pgottam-demo.livep/demobuild/minions-pc"
wait
clear

## Change to tonka in other tab
p "Let's modify pet clinic in another tab. This will cause TBS to rebuild the petclinic image using our later commit ID"

## Commit
## Need to watch for builds

pe "watch kp build list petclinic"
pe "kp build logs petclinic -b 2"
p "Now we can update our k8s deployment"
 pe "kubectl rollout restart deployment petclinic-deployment -n default"
wait
clear
## New tab

