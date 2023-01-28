#!/bin/bash

#cni.chainingMode https://docs.cilium.io/en/v1.12/gettingstarted/cni-chaining/
helm upgrade --install cilium cilium/cilium --version 1.12.6  --namespace kube-system \
  --set cni.exclusive=false \
  --set ipam.operator.clusterPoolIPv4PodCIDRList[0]=10.245.0.0/16 \
  --set operator.skipCNPStatusStartupClean=true \
  --set operator.unmanagedPodWatcher.restart=false