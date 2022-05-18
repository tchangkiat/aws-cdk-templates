#!/bin/bash

eksctl delete iamserviceaccount \
--cluster=$AWS_EKS_CLUSTER \
--name=appmesh-controller \
--namespace=appmesh-system

# $1: namespace
aws cloudformation delete-stack --stack-name AppMeshProxyAuthPolicy-$AWS_EKS_CLUSTER-$1-mesh

kubectl delete -f "appmesh/virtual-service.yaml"

kubectl delete -f "appmesh/virtual-router.yaml"

kubectl delete -f "appmesh/virtual-node.yaml"

kubectl delete -f "appmesh/mesh.yaml"

kubectl delete -f "appmesh/namespace.yaml"

rm –rf appmesh