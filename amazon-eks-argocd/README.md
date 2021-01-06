# DevOps - EKS with ArgoCD Pipeline

## Install eksctl and kubectl
https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html

## Deploy EKS Cluster

https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html

```
eksctl create cluster \
--name kc-devops-05 \
--version 1.18 \
--region ap-northeast-2 \
--nodegroup-name linux-nodes \
--nodes 1 \
--nodes-min 1 \
--nodes-max 3 \
--with-oidc \
--ssh-access \
--ssh-public-key kc-seoul-devops \
--managed \
--alb-ingress-access
```

```
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: devops-eks-demo
  region: ap-northeast-2

availabilityZones: ["ap-northeast-2a", "ap-northeast-2c"]
managedNodeGroups:
- name: gitops-workers
  desiredCapacity: 1
  iam:
    withAddonPolicies:
      albIngress: true
  ssh:
    publicKeyName: "kc-seoul-devops"

cloudWatch:
    clusterLogging:
        enableTypes: ["audit", "authenticator", "controllerManager"]

```
