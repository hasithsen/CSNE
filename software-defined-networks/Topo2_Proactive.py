#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

"""
Implement proactive controller for below topology.

          [c1]
           /\
          /  \
         /    \
        /      \
    [s1]--------[s2]
     /\          /\
 [h1]  [h2]  [h3]  [h4]

 [cX] - controller
 [sX] - switch
 [hX] - host
"""

from pox.core import core
import pox.openflow.libopenflow_01 as of
from pox.lib.util import dpidToStr

__email__ = "i@hsen.tech"
__date__ = "2020/4/1"

log = core.getLogger()
s1_dpid=0
s2_dpid=1

def _handle_ConnectionUp(event):
  """ Send rules to populate flow table of each switch """
    
  # We have 2 switches
  global s1_dpid 
  global s2_dpid 
  
  print "ConnectionUp: ", dpidToStr(event.connection.dpid)

  # Print connection dpid for each switch
  for m in event.connection.features.ports:
    if m.name == "s1-eth1":
      s1_dpid = event.connection.dpid
      print "s1_dpid=", s1_dpid
    elif m.name == "s2-eth1":
      s2_dpid = event.connection.dpid
      print "s2_dpid=", s2_dpid

  # Rules for s1
  if event.connection.dpid == s1_dpid:
    # Flood ARP packets
    msg = of.ofp_flow_mod()
    msg.priority=1
    msg.idle_timeout = 0
    msg.hard_timeout = 0
    msg.match.dl_type = 0x0806
    msg.actions.append(of.ofp_action_output(port= of.OFPP_ALL))
    event.connection.send(msg)
    
    # If destination is 10.0.0.1, outport is 1
    msg = of.ofp_flow_mod()
    msg.priority=10
    msg.idle_timeout = 0
    msg.hard_timeout = 0
    msg.match.dl_type = 0x0800
    msg.match.nw_dst = "10.0.0.1"
    msg.actions.append(of.ofp_action_output(port=1))
    event.connection.send(msg)
    
    # If destination is 10.0.0.2, outport is 2
    msg = of.ofp_flow_mod()
    msg.priority=10
    msg.idle_timeout = 0
    msg.hard_timeout = 0
    msg.match.dl_type = 0x0800
    msg.match.nw_dst = "10.0.0.2"
    msg.actions.append(of.ofp_action_output(port=2))
    event.connection.send(msg)

    # If destination is 10.0.0.3, outport is 3
    msg = of.ofp_flow_mod()
    msg.priority=10
    msg.idle_timeout = 0
    msg.hard_timeout = 0
    msg.match.dl_type = 0x0800
    msg.match.nw_dst = "10.0.0.3"
    msg.actions.append(of.ofp_action_output(port=3))
    event.connection.send(msg)

    # If destination is 10.0.0.4, outport is 3
    msg = of.ofp_flow_mod()
    msg.priority=10
    msg.idle_timeout = 0
    msg.hard_timeout = 0
    msg.match.dl_type = 0x0800
    msg.match.nw_dst = "10.0.0.4"
    msg.actions.append(of.ofp_action_output(port=3))
    event.connection.send(msg)

  # Rules for s2
  elif event.connection.dpid == s2_dpid:
    # Flood ARP packets
    msg = of.ofp_flow_mod()
    msg.priority=1
    msg.idle_timeout = 0 
    msg.hard_timeout = 0 
    msg.match.dl_type = 0x0806
    msg.actions.append(of.ofp_action_output(port= of.OFPP_ALL))
    event.connection.send(msg)
        
    # If destination is 10.0.0.1, outport is 3
    msg = of.ofp_flow_mod()
    msg.priority=10
    msg.idle_timeout = 0 
    msg.hard_timeout = 0 
    msg.match.dl_type = 0x0800
    msg.match.nw_dst = "10.0.0.1"
    msg.actions.append(of.ofp_action_output(port=3))
    event.connection.send(msg)
    
    # If destination is 10.0.0.2, outport is 3
    msg = of.ofp_flow_mod()
    msg.priority=10
    msg.idle_timeout = 0
    msg.hard_timeout = 0
    msg.match.dl_type = 0x0800
    msg.match.nw_dst = "10.0.0.2"
    msg.actions.append(of.ofp_action_output(port=3))
    event.connection.send(msg)

    # If destination is 10.0.0.3, outport is 1
    msg = of.ofp_flow_mod()
    msg.priority=10
    msg.idle_timeout = 0
    msg.hard_timeout = 0
    msg.match.dl_type = 0x0800
    msg.match.nw_dst = "10.0.0.3"
    msg.actions.append(of.ofp_action_output(port=1))
    event.connection.send(msg)

    # If destination is 10.0.0.4, outport is 2
    msg = of.ofp_flow_mod()
    msg.priority=10
    msg.idle_timeout = 0
    msg.hard_timeout = 0
    msg.match.dl_type = 0x0800
    msg.match.nw_dst = "10.0.0.4"
    msg.actions.append(of.ofp_action_output(port=2))
    event.connection.send(msg)

def launch():
  core.openflow.addListenerByName("ConnectionUp", _handle_ConnectionUp)

