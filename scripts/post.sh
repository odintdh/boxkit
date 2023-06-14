#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
cd /tmp/
echo 'Add azure-devops extension'
az extension add --name azure-devops
echo 'Add awscliv2'
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install --bin-dir /usr/bin --install-dir /usr/bin/installationaws/aws-cli --update
#echo "Add kubectl"
#curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#install -o root -g root -m 0755 kubectl /usr/bin/kubectl
echo "Add kubelogin"
curl -LO "https://github.com/Azure/kubelogin/releases/download/v0.0.29/kubelogin-linux-amd64.zip" -o "kubelogin-linux-amd64.zip"
unzip kubelogin-linux-amd64.zip
install -o root -g root -m 0755 bin/linux_amd64/kubelogin /usr/bin/kubelogin
echo "Add argocd-cli"
curl -LO "https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64" -o "argocd"
install -o root -g root -m 0755 argocd-linux-amd64 /usr/bin/argocd
echo "Add argocd rollouts"
curl -LO "https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-linux-amd64" -o "kubectl-argo-rollouts"
install -o root -g root -m 0755 kubectl-argo-rollouts-linux-amd64 /usr/bin/kubectl-argo-rollouts
echo "Add kind"
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.17.0/kind-$(uname)-amd64"
install -o root -g root -m 0755 kind /usr/bin/kind
echo "Add Terragrunt"
curl -Lo ./terragrunt_linux_amd64 "https://github.com/gruntwork-io/terragrunt/releases/download/v0.46.2/terragrunt_linux_amd64"
install -o root -g root -m 0755 terragrunt_linux_amd64 /usr/bin/terragrunt
echo "Add k9s"
curl -Lo k9s_Linux_amd64.tar.gz "https://github.com/derailed/k9s/releases/download/v0.27.4/k9s_Linux_amd64.tar.gz"
tar xvf ./k9s_Linux_amd64.tar.gz
install -o root -g root -m 0755 k9s /usr/bin/k9s
rm -rf /tmp/*
