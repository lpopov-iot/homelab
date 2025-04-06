# Local

## Kubectl
install kubectl
```
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

   chmod +x kubectl

   mkdir -p ~/.local/bin
   mv ./kubectl ~/.local/bin/kubectl
```

Ensure kubectl on PATH

### Add autocomplete and alias
```
source <(kubectl completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k
```

## K9s
```
wget https://github.com/derailed/k9s/releases/download/v0.40.10/k9s_linux_arm64.deb

sudo apt install ./k9s_linux_amd64.deb && rm k9s_linux_amd64.deb
```

## Helm

```
wget https://get.helm.sh/helm-v3.17.2-linux-amd64.tar.gz

tar -zxvf helm-v3.17.2-linux-amd64.tar.gz

sudo mv linux-amd64/helm /usr/local/bin/ && rm -rf linux-amd64/
```


# Tweaking machine
ansible-playbook playbooks/main.yml --ask-become-pass

# Installing k3s-ansible
```
ansible-galaxy collection install git+https://github.com/k3s-io/k3s-ansible.git
```

