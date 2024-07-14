#!/bin/bash

set -e

echo "Install Docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

echo "Install Kubernetes"
sudo apt-get update
sudo apt-get install -y apt-transport-https curl

#curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
#echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
#sudo apt-get update
#sudo apt-get install -y kubelet kubeadm kubectl
#sudo apt-mark hold kubelet kubeadm kubectl


curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt install -y kubeadm=1.28.1-1.1 kubelet=1.28.1-1.1 kubectl=1.28.1-1.1
sudo apt-mark hold kubeadm=1.28.1-1.1 kubelet=1.28.1-1.1 kubectl=1.28.1-1.1


echo "Disable swap"
sudo sed -i '/ swap / s/^/#/' /etc/fstab
sudo swapoff -a

echo "Enable CRI plugin in containerd"
sudo sed -i '/disabled_plugins = \["cri"\]/d' /etc/containerd/config.toml
sudo systemctl restart containerd

echo "Done"