# Project target

Target of this project is to check how (if) to switch cni operators without downtime. 
Inspired by https://cilium.io/blog/2020/10/06/skybet-cilium-migration/

## Sources

https://github.com/cilium/cilium/pull/14192/files - switch of cilium renaming other cni's configs

https://github.com/k8snetworkplumbingwg/multus-cni/issues/560 - another important pointer

Materials:
* https://devopstales.github.io/kubernetes/multus/
* https://m.youtube.com/watch?v=bIYZrSoGTFg

Possible replacement to multus - cni-genie:
https://www.linkedin.com/pulse/multi-cni-containers-network-interfaces-kubernetes-gokul-chandra
https://github.com/cni-genie/CNI-Genie
It doesn't look like actively maintained and doesn't support cilium. 

# Procedure

## Initial setup

1. create kind cluster: `./10_start_cluster.sh`
2. Install calico & goldpinger: `./20_initial_state.sh `

## Monitoring network

Each node exposes goldpinger as a node port as a service on ports 30080, 31080, 32080, 33080. To check it open http://127.0.0.1:30080/

## Migration

1. Install multus with calico: `./30_install_multus.sh`
2. Install cilium: `./40_install_cilium.sh`
3. Enable both CNIs: `./50_calico_default.sh`
4. Switch to cilium as default: `./60_cilium_default.sh` - step not needed????
    * https://github.com/k8snetworkplumbingwg/multus-cni/pull/314
    * https://github.com/projectcalico/calico/issues/5199
5. Switch to cilium `./70_cilium.sh`
   1. old pods can't communicate with new ones