
#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0

BGP=1
ISIS=0

if [ $# -gt 0 ]
   then
   if [ $1 == "bgp" ]
      then
         BGP=1
         ISIS=0
   elif [ $1 == "isis" ]
      then
         BGP=0
         ISIS=1
   elif [ $1 != "bgp" -a $1 != "isis" ]
      then
         echo "Wrong argument " $1 ", has to be bgp or isis"
   fi
fi

sudo ip netns add h1
sudo ip netns add h2
sudo ip netns add r2
sudo ip netns add r3
sudo ip netns add r4
sudo ip netns add r5
sudo ip netns add r6
sudo ip netns add r7
sudo ip netns add r8

sudo ip netns exec h1 ip link set dev lo up
sudo ip netns exec h2 ip link set dev lo up
sudo ip netns exec r2 ip link set dev lo up
sudo ip netns exec r3 ip link set dev lo up
sudo ip netns exec r4 ip link set dev lo up
sudo ip netns exec r5 ip link set dev lo up
sudo ip netns exec r6 ip link set dev lo up
sudo ip netns exec r7 ip link set dev lo up
sudo ip netns exec r8 ip link set dev lo up

sudo ip -6 addr add fcff:0:1::1/48 dev lo
sudo ip netns exec r2 ip -6 addr add fcff:0:2::1/48 dev lo
sudo ip netns exec r3 ip -6 addr add fcff:0:3::1/48 dev lo
sudo ip netns exec r4 ip -6 addr add fcff:0:4::1/48 dev lo
sudo ip netns exec r5 ip -6 addr add fcff:0:5::1/48 dev lo
sudo ip netns exec r6 ip -6 addr add fcff:0:6::1/48 dev lo
sudo ip netns exec r7 ip -6 addr add fcff:0:7::1/48 dev lo
sudo ip netns exec r8 ip -6 addr add fcff:0:8::1/48 dev lo

sudo sysctl net.ipv6.conf.all.forwarding=1
sudo ip netns exec r2 sysctl net.ipv6.conf.all.forwarding=1
sudo ip netns exec r3 sysctl net.ipv6.conf.all.forwarding=1
sudo ip netns exec r4 sysctl net.ipv6.conf.all.forwarding=1
sudo ip netns exec r5 sysctl net.ipv6.conf.all.forwarding=1
sudo ip netns exec r6 sysctl net.ipv6.conf.all.forwarding=1
sudo ip netns exec r7 sysctl net.ipv6.conf.all.forwarding=1
sudo ip netns exec r8 sysctl net.ipv6.conf.all.forwarding=1

sudo sysctl net.ipv6.conf.all.seg6_enabled=1
sudo ip netns exec r2 sysctl net.ipv6.conf.all.seg6_enabled=1
sudo ip netns exec r3 sysctl net.ipv6.conf.all.seg6_enabled=1
sudo ip netns exec r4 sysctl net.ipv6.conf.all.seg6_enabled=1
sudo ip netns exec r5 sysctl net.ipv6.conf.all.seg6_enabled=1
sudo ip netns exec r6 sysctl net.ipv6.conf.all.seg6_enabled=1
sudo ip netns exec r7 sysctl net.ipv6.conf.all.seg6_enabled=1
sudo ip netns exec r8 sysctl net.ipv6.conf.all.seg6_enabled=1

sudo sysctl net.ipv6.conf.default.seg6_enabled=1
sudo ip netns exec r2 sysctl net.ipv6.conf.default.seg6_enabled=1
sudo ip netns exec r3 sysctl net.ipv6.conf.default.seg6_enabled=1
sudo ip netns exec r4 sysctl net.ipv6.conf.default.seg6_enabled=1
sudo ip netns exec r5 sysctl net.ipv6.conf.default.seg6_enabled=1
sudo ip netns exec r6 sysctl net.ipv6.conf.default.seg6_enabled=1
sudo ip netns exec r7 sysctl net.ipv6.conf.default.seg6_enabled=1
sudo ip netns exec r8 sysctl net.ipv6.conf.default.seg6_enabled=1

sudo sysctl net.ipv6.conf.all.accept_source_route=1
sudo ip netns exec r2 sysctl net.ipv6.conf.all.accept_source_route=1
sudo ip netns exec r3 sysctl net.ipv6.conf.all.accept_source_route=1
sudo ip netns exec r4 sysctl net.ipv6.conf.all.accept_source_route=1
sudo ip netns exec r5 sysctl net.ipv6.conf.all.accept_source_route=1
sudo ip netns exec r6 sysctl net.ipv6.conf.all.accept_source_route=1
sudo ip netns exec r7 sysctl net.ipv6.conf.all.accept_source_route=1
sudo ip netns exec r8 sysctl net.ipv6.conf.all.accept_source_route=1

sudo sysctl net.ipv6.conf.default.accept_source_route=1
sudo ip netns exec r2 sysctl net.ipv6.conf.default.accept_source_route=1
sudo ip netns exec r3 sysctl net.ipv6.conf.default.accept_source_route=1
sudo ip netns exec r4 sysctl net.ipv6.conf.default.accept_source_route=1
sudo ip netns exec r5 sysctl net.ipv6.conf.default.accept_source_route=1
sudo ip netns exec r6 sysctl net.ipv6.conf.default.accept_source_route=1
sudo ip netns exec r7 sysctl net.ipv6.conf.default.accept_source_route=1
sudo ip netns exec r8 sysctl net.ipv6.conf.default.accept_source_route=1

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns h1
sudo ip netns exec h1 ip link set v1 name h1r1
sudo ip netns exec h1 ip link set h1r1 up
sudo ip link set v2 name r1h1
sudo ip link set r1h1 up

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r2
sudo ip netns exec r2 ip link set v1 name r2r1
sudo ip netns exec r2 ip link set r2r1 addr 00:00:00:00:00:21
sudo ip netns exec r2 ip link set r2r1 up
sudo ip link set v2 name r1r2
sudo ip link set r1r2 up

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r5
sudo ip netns exec r5 ip link set v1 name r5r1
sudo ip netns exec r5 ip link set r5r1 addr 00:00:00:00:00:51
sudo ip netns exec r5 ip link set r5r1 up
sudo ip link set v2 name r1r5
sudo ip link set r1r5 up

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r6
sudo ip netns exec r6 ip link set v1 name r6r1
sudo ip netns exec r6 ip link set r6r1 addr 00:00:00:00:00:61
sudo ip netns exec r6 ip link set r6r1 up
sudo ip link set v2 name r1r6
sudo ip link set r1r6 up

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r7
sudo ip netns exec r7 ip link set v1 name r7r1-1
sudo ip link set v2 name r1r7-1
sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r7
sudo ip netns exec r7 ip link set v1 name r7r1-2
sudo ip link set v2 name r1r7-2
sudo ip link add bond7 type bond mode 802.3ad
sudo ip link set r1r7-1 master bond7
sudo ip link set r1r7-2 master bond7
sudo ip link set bond7 up
sudo ip netns exec r7 ip link add bond1 type bond mode 802.3ad
sudo ip netns exec r7 ip link set bond1 addr 00:00:00:00:00:71
sudo ip netns exec r7 ip link set r7r1-1 master bond1
sudo ip netns exec r7 ip link set r7r1-2 master bond1
sudo ip netns exec r7 ip link set bond1 up

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r8
sudo ip netns exec r8 ip link set v1 name r8r1-1
sudo ip link set v2 name r1r8-1
sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r8
sudo ip netns exec r8 ip link set v1 name r8r1-2
sudo ip link set v2 name r1r8-2
sudo ip link add bond8 type bond mode 802.3ad
sudo ip link set r1r8-1 master bond8
sudo ip link set r1r8-2 master bond8
sudo ip link set bond8 up
sudo ip link add name bond8.123 link bond8 type vlan id 123
sudo ip link set bond8.123 up
sudo ip netns exec r8 ip link add bond1 type bond mode 802.3ad
sudo ip netns exec r8 ip link set bond1 addr 00:00:00:00:00:81
sudo ip netns exec r8 ip link set r8r1-1 master bond1
sudo ip netns exec r8 ip link set r8r1-2 master bond1
sudo ip netns exec r8 ip link set bond1 up
sudo ip netns exec r8 ip link add name bond1.123 link bond1 type vlan id 123
sudo ip netns exec r8 ip link set bond1.123 up

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r2
sudo ip netns exec r2 ip link set v1 name r2r3
sudo ip netns exec r2 ip link set r2r3 up
sudo ip link set dev v2 netns r3
sudo ip netns exec r3 ip link set v2 name r3r2
sudo ip netns exec r3 ip link set r3r2 up

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r3
sudo ip netns exec r3 ip link set v1 name r3r4
sudo ip netns exec r3 ip link set r3r4 addr 00:00:00:00:00:34
sudo ip netns exec r3 ip link set r3r4 up
sudo ip link set dev v2 netns r4
sudo ip netns exec r4 ip link set v2 name r4r3
sudo ip netns exec r4 ip link set r4r3 up

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r4
sudo ip netns exec r4 ip link set v1 name r4r5
sudo ip netns exec r4 ip link set r4r5 addr 00:00:00:00:00:45
sudo ip netns exec r4 ip link set r4r5 up
sudo ip link set dev v2 netns r5
sudo ip netns exec r5 ip link set v2 name r5r4
sudo ip netns exec r5 ip link set r5r4 addr 00:00:00:00:00:54
sudo ip netns exec r5 ip link set r5r4 up

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r4
sudo ip netns exec r4 ip link set v1 name r4r6
sudo ip netns exec r4 ip link set r4r6 up
sudo ip link set dev v2 netns r6
sudo ip netns exec r6 ip link set v2 name r6r4
sudo ip netns exec r6 ip link set r6r4 addr 00:00:00:00:00:64
sudo ip netns exec r6 ip link set r6r4 up

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r4
sudo ip link set dev v2 netns r7
sudo ip netns exec r4 ip link set v1 name r4r7-1
sudo ip netns exec r7 ip link set v2 name r7r4-1
sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r4
sudo ip link set dev v2 netns r7
sudo ip netns exec r4 ip link set v1 name r4r7-2
sudo ip netns exec r7 ip link set v2 name r7r4-2
sudo ip netns exec r4 ip link add bond7 type bond mode 802.3ad
sudo ip netns exec r4 ip link set r4r7-1 master bond7
sudo ip netns exec r4 ip link set r4r7-2 master bond7
sudo ip netns exec r4 ip link set bond7 up
sudo ip netns exec r7 ip link add bond4 type bond mode 802.3ad
sudo ip netns exec r7 ip link set bond4 addr 00:00:00:00:00:74
sudo ip netns exec r7 ip link set r7r4-1 master bond4
sudo ip netns exec r7 ip link set r7r4-2 master bond4
sudo ip netns exec r7 ip link set bond4 up

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r4
sudo ip link set dev v2 netns r8
sudo ip netns exec r4 ip link set v1 name r4r8-1
sudo ip netns exec r8 ip link set v2 name r8r4-1
sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r4
sudo ip link set dev v2 netns r8
sudo ip netns exec r4 ip link set v1 name r4r8-2
sudo ip netns exec r8 ip link set v2 name r8r4-2
sudo ip netns exec r4 ip link add bond8 type bond mode 802.3ad
sudo ip netns exec r4 ip link set r4r8-1 master bond8
sudo ip netns exec r4 ip link set r4r8-2 master bond8
sudo ip netns exec r4 ip link set bond8 up
sudo ip netns exec r8 ip link add bond4 type bond mode 802.3ad
sudo ip netns exec r8 ip link set bond4 addr 00:00:00:00:00:84
sudo ip netns exec r8 ip link set r8r4-1 master bond4
sudo ip netns exec r8 ip link set r8r4-2 master bond4
sudo ip netns exec r8 ip link set bond4 up

sudo ip link add v1 type veth peer v2
sudo ip link set dev v1 netns r4
sudo ip netns exec r4 ip link set v1 name r4h2
sudo ip netns exec r4 ip link set r4h2 up
sudo ip link set dev v2 netns h2
sudo ip netns exec h2 ip link set v2 name h2r4
sudo ip netns exec h2 ip link set h2r4 up

sudo ip link add vrf10 type vrf table 10
sudo ip link set vrf10 up
sudo sysctl net.vrf.strict_mode=1
sudo ip link set r1h1 master vrf10
sudo ip addr add 169.254.0.1/16 dev r1h1
sudo ip -6 addr add fe80::1/128 dev r1h1
sudo ip route add table 10 10.0.1.1/32 dev r1h1
sudo ip -6 route add table 10 4444::1/128 dev r1h1

sudo ip netns exec h1 ip addr add 10.0.1.1/32 dev h1r1
sudo ip netns exec h1 ip route add 169.254.0.0/16 dev h1r1
sudo ip netns exec h1 ip route add 10.0.1.0/24 via 169.254.0.1 dev h1r1
sudo ip netns exec h1 ip -6 addr add 4444::1/128 dev h1r1
sudo ip netns exec h1 ip -6 route add 4444::/64 via fe80::1 dev h1r1

sudo ip netns exec r4 ip link add vrf10 type vrf table 10
sudo ip netns exec r4 ip link set vrf10 up
sudo ip netns exec r4 sysctl net.vrf.strict_mode=1
sudo ip netns exec r4 ip link set r4h2 master vrf10
sudo ip netns exec r4 ip addr add 169.254.0.1/16 dev r4h2
sudo ip netns exec r4 ip -6 addr add fe80::1/128 dev r4h2
sudo ip netns exec r4 ip route add table 10 10.0.1.2/32 dev r4h2
sudo ip netns exec r4 ip -6 route add table 10 4444::2/128 dev r4h2

sudo ip netns exec h2 ip addr add 10.0.1.2/32 dev h2r4
sudo ip netns exec h2 ip route add 169.254.0.0/16 dev h2r4
sudo ip netns exec h2 ip route add 10.0.1.0/24 via 169.254.0.1 dev h2r4
sudo ip netns exec h2 ip -6 addr add 4444::2/128 dev h2r4
sudo ip netns exec h2 ip -6 route add 4444::/64 via fe80::1 dev h2r4

if [ $BGP -eq 1 ]
   then
      docker run -itd \
         --name frr-r1 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/bgp-r1:/etc/frr:rw \
         -v $PWD/bgp-r1/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "/usr/bin/tini" \
         frr \
         /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r2 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/bgp-r2:/etc/frr:rw \
         -v $PWD/bgp-r2/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r2 /usr/bin/tini /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r3 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/bgp-r3:/etc/frr:rw \
         -v $PWD/bgp-r3/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r3 /usr/bin/tini /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r4 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/bgp-r4:/etc/frr:rw \
         -v $PWD/bgp-r4/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r4 /usr/bin/tini /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r5 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/bgp-r5:/etc/frr:rw \
         -v $PWD/bgp-r5/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r5 /usr/bin/tini /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r6 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/bgp-r6:/etc/frr:rw \
         -v $PWD/bgp-r6/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r6 /usr/bin/tini /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r7 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/bgp-r7:/etc/frr:rw \
         -v $PWD/bgp-r7/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r7 /usr/bin/tini /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r8 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/bgp-r8:/etc/frr:rw \
         -v $PWD/bgp-r8/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r8 /usr/bin/tini /usr/lib/frr/frr-start --

      echo "BGP routing"
elif [ $ISIS -eq 1 ]
   then
      docker run -itd \
         --name frr-r1 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/isis-r1:/etc/frr:rw \
         -v $PWD/isis-r1/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "/usr/bin/tini" \
         frr \
         /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r2 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/isis-r2:/etc/frr:rw \
         -v $PWD/isis-r2/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r2 /usr/bin/tini /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r3 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/isis-r3:/etc/frr:rw \
         -v $PWD/isis-r3/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r3 /usr/bin/tini /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r4 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/isis-r4:/etc/frr:rw \
         -v $PWD/isis-r4/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r4 /usr/bin/tini /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r5 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/isis-r5:/etc/frr:rw \
         -v $PWD/isis-r5/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r5 /usr/bin/tini /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r6 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/isis-r6:/etc/frr:rw \
         -v $PWD/isis-r6/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r6 /usr/bin/tini /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r7 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/isis-r7:/etc/frr:rw \
         -v $PWD/isis-r7/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r7 /usr/bin/tini /usr/lib/frr/frr-start --

      docker run -itd \
         --name frr-r8 \
         --network host \
         --privileged \
         -v /etc/localtime:/etc/localtime:ro \
         -v /etc/timezone:/etc/timezone:ro \
         -v $PWD/isis-r8:/etc/frr:rw \
         -v $PWD/isis-r8/services:/etc/services:ro \
         -v /var/run/netns:/var/run/netns:rw \
         --entrypoint "ip" \
         frr \
         netns exec r8 /usr/bin/tini /usr/lib/frr/frr-start --

      echo "ISIS routing"
fi
