#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0

sudo ip -6 addr del fcff:0:1::1/48 dev lo
sudo ip route del table 10 10.0.1.2
sudo ip -6 route del table 10 4444::2/128
sudo ip link del vrf10
sudo ip link del bond7
sudo ip link del bond8
sudo ip link del r1r2
sudo ip link del r1r7-1
sudo ip link del r1r7-2
sudo ip link del r1r8-1
sudo ip link del r1r8-2

docker stop frr-r1
docker stop frr-r2
docker stop frr-r3
docker stop frr-r4
docker stop frr-r5
docker stop frr-r6
docker stop frr-r7
docker stop frr-r8

docker rm frr-r1
docker rm frr-r2
docker rm frr-r3
docker rm frr-r4
docker rm frr-r5
docker rm frr-r6
docker rm frr-r7
docker rm frr-r8

sudo ip netns del h1
sudo ip netns del h2
sudo ip netns del r2
sudo ip netns del r3
sudo ip netns del r4
sudo ip netns del r5
sudo ip netns del r6
sudo ip netns del r7
sudo ip netns del r8
