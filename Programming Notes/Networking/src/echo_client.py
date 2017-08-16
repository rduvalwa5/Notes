'''
Created on Nov 2, 2014

@author: rduvalwa2
'''
"""
Client side: use sockets to send data to the server, and print server's
reply to each message line; 'localhost' means that the server is running
on the same machine as the client, which lets us test client and server
on one machine; to test over the Internet, run a server on a remote
machine, and set serverHost or argv[1] to machine's domain name or IP addr;
Python sockets are a portable BSD socket interface, with object methods
for the standard socket calls available in the system's C library;

AF_INET is the address family that is used for the socket creating an Internet Protocol address
Linux kernel, supports 29 other address families such as UNIX sockets and IPX, and also communications with IRDA and Bluetooth 
(AF_IRDA and AF_BLUETOOTH, but it is doubtful you'll use these at such a low level).

need arguments like AF_UNIX or AF_INET to specify which type of socket addressing you would be using to implement IPC socket
communication. AF stands for Address Family.
As in BSD standard Socket (adopted in Python socket module) addresses are represented as follows:
   A single string is used for the AF_UNIX/AF_LOCAL address family. 
   This option is used for IPC on local machines where no IP address is required.
   A pair (host, port) is used for the AF_INET address family, where host is a string representing either a hostname 
   in Internet domain notation like 'daring.cwi.nl' or an IPv4 address like '100.50.200.5', and port is an integer. 
   Used to communicated between processes over internet.
AF_UNIX , AF_INET6 , AF_NETLINK , AF_TIPC , AF_CAN , AF_BLUETOOTH , AF_PACKET , AF_RDS are other option which could be used instead of AF_INET.
"""
import sys
from socket import *  # portable socket interface plus constants
serverHost = 'localhost'   # server name or 'starship.python.net'
serverPort  = 50007

message = [b'Hello network workd']      # default text to send to server
                                        # requires bytes: b'' or str, encode()
if len(sys.argv) > 1:
    serverHost = sys.argv[1]            # server from cmd lione arg 1
    if len(sys.argv) > 2:               # test from cmd line args 2...n
        message = (x.encode() for x in sys.argv[2:])
        
sockobj = socket(AF_INET, SOCK_STREAM)     # make a TCP?IP soclet object
sockobj.connect((serverHost, serverPort))   # conect to server

for line in message:
    sockobj.send(line)              # send line to server
    data = sockobj.recv(1024)       # receive line from server up to 1k
    print('Client recieved:', data)
    
sockobj.close()