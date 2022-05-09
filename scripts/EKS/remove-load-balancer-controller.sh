#!/bin/bash

rm aws-load-balancer-controller-policy.json

helm uninstall aws-load-balancer-controller -n kube-system

kubectl delete -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"

kubectl delete serviceaccount aws-load-balancer-controller -n kube-system

eksctl delete iamserviceaccount \
--cluster=$AWS_EKS_CLUSTER \
--name=aws-load-balancer-controller \
--namespace=kube-system

aws iam delete-policy \
 --policy-arn arn:aws:iam::$AWS_ACCOUNT_ID:policy/eks-$AWS_EKS_CLUSTER-aws-load-balancer-controller