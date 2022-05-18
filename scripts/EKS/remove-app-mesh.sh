#!/bin/bash

eksctl delete iamserviceaccount \
--cluster=$AWS_EKS_CLUSTER \
--name=$1 \
--namespace=$2

# $1: application name
# $2: namespace
aws cloudformation delete-stack --stack-name AppMeshProxyAuthPolicy-$AWS_EKS_CLUSTER-$2-mesh

kubectl delete -f "appmesh/virtual-service.yaml"

kubectl delete -f "appmesh/virtual-router.yaml"

kubectl delete -f "appmesh/virtual-node.yaml"

kubectl delete -f "appmesh/mesh.yaml"

kubectl delete -f "appmesh/namespace.yaml"

sudo rm appmesh -rf