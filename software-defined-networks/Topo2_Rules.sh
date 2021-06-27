#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# email: i@hsen.tech
# date : 2020/4/1

# s1 flows
sudo ovs-ofctl add-flow s1 eth_type=0x800,nw_src=10.0.0.1,nw_dst=10.0.0.2,actions=output:2
sudo ovs-ofctl add-flow s1 eth_type=0x800,nw_src=10.0.0.2,nw_dst=10.0.0.1,actions=output:1
sudo ovs-ofctl add-flow s1 eth_type=0x800,nw_src=10.0.0.1,nw_dst=10.0.0.3,actions=output:3
sudo ovs-ofctl add-flow s1 eth_type=0x800,nw_src=10.0.0.1,nw_dst=10.0.0.4,actions=output:3
sudo ovs-ofctl add-flow s1 eth_type=0x800,nw_src=10.0.0.2,nw_dst=10.0.0.3,actions=output:3
sudo ovs-ofctl add-flow s1 eth_type=0x800,nw_src=10.0.0.2,nw_dst=10.0.0.4,actions=output:3
sudo ovs-ofctl add-flow s1 eth_type=0x800,nw_src=10.0.0.3,nw_dst=10.0.0.1,actions=output:1
sudo ovs-ofctl add-flow s1 eth_type=0x800,nw_src=10.0.0.3,nw_dst=10.0.0.2,actions=output:2
sudo ovs-ofctl add-flow s1 eth_type=0x800,nw_src=10.0.0.4,nw_dst=10.0.0.1,actions=output:1
sudo ovs-ofctl add-flow s1 eth_type=0x800,nw_src=10.0.0.4,nw_dst=10.0.0.2,actions=output:2
sudo ovs-ofctl add-flow s1 eth_type=0x806,actions=output:ALL

# s2 flows
sudo ovs-ofctl add-flow s2 eth_type=0x800,nw_src=10.0.0.3,nw_dst=10.0.0.4,actions=output:2
sudo ovs-ofctl add-flow s2 eth_type=0x800,nw_src=10.0.0.4,nw_dst=10.0.0.3,actions=output:1
sudo ovs-ofctl add-flow s2 eth_type=0x800,nw_src=10.0.0.3,nw_dst=10.0.0.1,actions=output:3
sudo ovs-ofctl add-flow s2 eth_type=0x800,nw_src=10.0.0.3,nw_dst=10.0.0.2,actions=output:3
sudo ovs-ofctl add-flow s2 eth_type=0x800,nw_src=10.0.0.4,nw_dst=10.0.0.1,actions=output:3
sudo ovs-ofctl add-flow s2 eth_type=0x800,nw_src=10.0.0.4,nw_dst=10.0.0.2,actions=output:3
sudo ovs-ofctl add-flow s2 eth_type=0x800,nw_src=10.0.0.1,nw_dst=10.0.0.3,actions=output:1
sudo ovs-ofctl add-flow s2 eth_type=0x800,nw_src=10.0.0.1,nw_dst=10.0.0.4,actions=output:2
sudo ovs-ofctl add-flow s2 eth_type=0x800,nw_src=10.0.0.2,nw_dst=10.0.0.3,actions=output:1
sudo ovs-ofctl add-flow s2 eth_type=0x800,nw_src=10.0.0.2,nw_dst=10.0.0.4,actions=output:2
sudo ovs-ofctl add-flow s2 eth_type=0x806,actions=output:ALL
