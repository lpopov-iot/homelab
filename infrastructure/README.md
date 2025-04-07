# Setup single node K3s on remote
 
 ## Install K3sUp (ketchup)
 https://github.com/alexellis/k3sup

 ## Create cluster
 
 ### prereq
https://github.com/alexellis/k3sup?tab=readme-ov-file#pre-requisites-for-k3sup-servers-and-agents

### Install
 ```
export IP={server-ip}
export USER={remove-user}


k3sup install --ip $IP \
  --no-extras \
  --k3s-version v1.32.3+k3s1\
  --user $USER \
  --merge
  --context k3s
 ```

 ## Flux

 ```
 curl -s https://fluxcd.io/install.sh | sudo bash

 . <(flux completion bash)
 ```

 ```
 export GITHUB_TOKEN=<gh-token>
 flux bootstrap github \
 --repository homelab \
 --branch master \
 --owner lpopov-iot \
 --path clusters \
 --personal \
 --token-auth
 ```

 ```
 flux create source git podinfo \
  --url=https://github.com/stefanprodan/podinfo \
  --branch=master \
  --interval=10m \
  --export > ./clusters/my-cluster/podinfo-source.yaml
 ```