#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Create below topology in Mininet.

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

from mininet.net import Mininet
from mininet.node import Controller, OVSKernelSwitch, RemoteController
from mininet.cli import CLI
from mininet.log import setLogLevel, info

__email__ = "i@hsen.tech"
__date__ = "2020/4/1"

def alphaNet():
  """ Create topology and start Mininet CLI"""
    
  net = Mininet(controller=RemoteController, switch=OVSKernelSwitch)

  c1 = net.addController('c1', controller=RemoteController, ip='127.0.0.1', port=6633)

  h1 = net.addHost( 'h1', ip='10.0.0.1' )
  h2 = net.addHost( 'h2', ip='10.0.0.2' )
  h3 = net.addHost( 'h3', ip='10.0.0.3' )
  h4 = net.addHost( 'h4', ip='10.0.0.4' )

  s1 = net.addSwitch( 's1' )
  s2 = net.addSwitch( 's2' )

  s1.linkTo( h1 )
  s1.linkTo( h2 )
  s2.linkTo( h3 )
  s2.linkTo( h4 )
  s1.linkTo( s2 )

  net.build()
  net.staticArp()
  c1.start()
  s1.start([c1])
  s2.start([c1])
 
  CLI( net )
  net.stop()

if __name__ == '__main__':
  setLogLevel( 'info' )
  alphaNet()
