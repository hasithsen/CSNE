#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Implement (Ryu) proactive controller for below topology.

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

from ryu.base import app_manager
from ryu.controller.handler import set_ev_cls
from ryu.ofproto import ofproto_v1_0
from ryu.topology.event import EventSwitchEnter, EventSwitchLeave

__email__ = "i@hsen.tech"
__date__ = "2020/5/29"

s1_dpid = 1 # Hardcode s1 datapath ID according to Topo2
s2_dpid = 2

class Topo2ProactiveSwitch(app_manager.RyuApp):
  # Mark as compatible with only OpenFlow v1.0
  OFP_VERSIONS = [ofproto_v1_0.OFP_VERSION]

  # Create a subclass of RyuApp
  def __init__(self, *args, **kwargs):
    super(Topo2ProactiveSwitch, self).__init__(*args, **kwargs)

  @set_ev_cls(EventSwitchEnter) # Fires when a switch connects to controller
  def _ev_switch_enter_handler(self, ev):
    global s1_dpid
    global s2_dpid

    print('Fired: %s' % ev) 
    datapath = ev.switch.dp  # Extract datapath entity from event info
    ofproto = datapath.ofproto
    parser = datapath.ofproto_parser

    dpid = datapath.id
    ofproto = datapath.ofproto
 
    # Forwarding rules for s1
    if dpid == s1_dpid:
      # Flood ARP packets
      actions = [datapath.ofproto_parser.OFPActionOutput(ofproto.OFPP_FLOOD)]
  
      match = datapath.ofproto_parser.OFPMatch(
        dl_type = 0x0806)
      """ 
      Ignore other matching params
        in_port=
        dl_dst=
        dl_src=
      """
  
      mod = datapath.ofproto_parser.OFPFlowMod(
        datapath=datapath,
        match=match, 
        cookie=0,
        command=ofproto.OFPFC_ADD,
        idle_timeout=0,
        hard_timeout=0,
        priority=1, # 1 instead of ofproto.OFP_DEFAULT_PRIORITY
        flags=ofproto.OFPFF_SEND_FLOW_REM,
        actions=actions)
      datapath.send_msg(mod)
  
      # If destination is 10.0.0.1, outport is 1
      actions = [datapath.ofproto_parser.OFPActionOutput(1)]
  
      match = datapath.ofproto_parser.OFPMatch(
        dl_type = 0x0800,
        nw_dst = "10.0.0.1")
  
      mod = datapath.ofproto_parser.OFPFlowMod(
        datapath=datapath, 
        match=match, cookie=0,
        command=ofproto.OFPFC_ADD, 
        idle_timeout=0, 
        hard_timeout=0,
        priority=10,
        flags=ofproto.OFPFF_SEND_FLOW_REM, 
        actions=actions)
      datapath.send_msg(mod)
  
      # If destination is 10.0.0.2, outport is 2
      actions = [datapath.ofproto_parser.OFPActionOutput(2)]
  
      match = datapath.ofproto_parser.OFPMatch(
        dl_type = 0x0800,
        nw_dst = "10.0.0.2")
  
      mod = datapath.ofproto_parser.OFPFlowMod(
        datapath=datapath,
        match=match, 
        cookie=0,
        command=ofproto.OFPFC_ADD,
        idle_timeout=0,
        hard_timeout=0,
        priority=10,
        flags=ofproto.OFPFF_SEND_FLOW_REM,
        actions=actions)
      datapath.send_msg(mod)

      # If destination is 10.0.0.3, outport is 3
      actions = [datapath.ofproto_parser.OFPActionOutput(3)]
  
      match = datapath.ofproto_parser.OFPMatch(
        dl_type = 0x0800,
        nw_dst = "10.0.0.3")
  
      mod = datapath.ofproto_parser.OFPFlowMod(
        datapath=datapath, 
        match=match, cookie=0,
        command=ofproto.OFPFC_ADD, 
        idle_timeout=0, 
        hard_timeout=0,
        priority=10,
        flags=ofproto.OFPFF_SEND_FLOW_REM, 
        actions=actions)
      datapath.send_msg(mod)

      # If destination is 10.0.0.4, outport is 3
      actions = [datapath.ofproto_parser.OFPActionOutput(3)]
  
      match = datapath.ofproto_parser.OFPMatch(
        dl_type = 0x0800,
        nw_dst = "10.0.0.4")
  
      mod = datapath.ofproto_parser.OFPFlowMod(
        datapath=datapath, 
        match=match, cookie=0,
        command=ofproto.OFPFC_ADD, 
        idle_timeout=0, 
        hard_timeout=0,
        priority=10,
        flags=ofproto.OFPFF_SEND_FLOW_REM, 
        actions=actions)
      datapath.send_msg(mod)

    # Forwarding rules for s2
    elif dpid == s2_dpid:
      # Flood ARP packets
      actions = [datapath.ofproto_parser.OFPActionOutput(ofproto.OFPP_FLOOD)]

      match = datapath.ofproto_parser.OFPMatch(
        dl_type = 0x0806)

      mod = datapath.ofproto_parser.OFPFlowMod(
        datapath=datapath,
        match=match,
        cookie=0,
        command=ofproto.OFPFC_ADD,
        idle_timeout=0,
        hard_timeout=0,
        priority=1,
        flags=ofproto.OFPFF_SEND_FLOW_REM,
        actions=actions)
      datapath.send_msg(mod)

      # If destination is 10.0.0.1, outport is 3
      actions = [datapath.ofproto_parser.OFPActionOutput(3)]

      match = datapath.ofproto_parser.OFPMatch(
        dl_type = 0x0800,
        nw_dst = "10.0.0.1")

      mod = datapath.ofproto_parser.OFPFlowMod(
        datapath=datapath,
        match=match, cookie=0,
        command=ofproto.OFPFC_ADD,
        idle_timeout=0,
        hard_timeout=0,
        priority=10,
        flags=ofproto.OFPFF_SEND_FLOW_REM,
        actions=actions)
      datapath.send_msg(mod)

      # If destination is 10.0.0.2, outport is 3
      actions = [datapath.ofproto_parser.OFPActionOutput(3)]

      match = datapath.ofproto_parser.OFPMatch(
        dl_type = 0x0800,
        nw_dst = "10.0.0.2")

      mod = datapath.ofproto_parser.OFPFlowMod(
        datapath=datapath,
        match=match,
        cookie=0,
        command=ofproto.OFPFC_ADD,
        idle_timeout=0,
        hard_timeout=0,
        priority=10,
        flags=ofproto.OFPFF_SEND_FLOW_REM,
        actions=actions)
      datapath.send_msg(mod)

      # If destination is 10.0.0.3, outport is 1
      actions = [datapath.ofproto_parser.OFPActionOutput(1)]

      match = datapath.ofproto_parser.OFPMatch(
        dl_type = 0x0800,
        nw_dst = "10.0.0.3")

      mod = datapath.ofproto_parser.OFPFlowMod(
        datapath=datapath,
        match=match, cookie=0,
        command=ofproto.OFPFC_ADD,
        idle_timeout=0,
        hard_timeout=0,
        priority=10,
        flags=ofproto.OFPFF_SEND_FLOW_REM,
        actions=actions)
      datapath.send_msg(mod)

      # If destination is 10.0.0.4, outport is 2
      actions = [datapath.ofproto_parser.OFPActionOutput(2)]

      match = datapath.ofproto_parser.OFPMatch(
        dl_type = 0x0800,
        nw_dst = "10.0.0.4")

      mod = datapath.ofproto_parser.OFPFlowMod(
        datapath=datapath,
        match=match, cookie=0,
        command=ofproto.OFPFC_ADD,
        idle_timeout=0,
        hard_timeout=0,
        priority=10,
        flags=ofproto.OFPFF_SEND_FLOW_REM,
        actions=actions)
      datapath.send_msg(mod)

