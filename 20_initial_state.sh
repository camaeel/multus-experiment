#!/bin/bash

set -ex

for node in `kubectl get nodes -o custom-columns=name:.metadata.name --no-headers`; do
  docker exec $node sysctl -w fs.inotify.max_user_watches=100000
  docker exec $node sysctl -w fs.inotify.max_user_instances=100000
done


kubectl apply -f calico.yaml

kubectl apply -f goldpinger.yaml
