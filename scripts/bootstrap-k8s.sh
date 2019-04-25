#!/bin/sh

kubeadm init --pod-network-cidr=10.10.0.0/16

mkdir -p ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config

# install network plugin
kubectl apply -f ../k8s-manifests/calico

# install MetalLB
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.7.3/manifests/metallb.yaml
kubectl apply -f ../k8s-manifests/metallb
