'''
Created on Nov 2, 2014

@author: rduvalwa2
'''
"""
Server side: open a TCP/IP socket on a port, listen for a message from
a client, and send an echo reply; this is a simple one-shot listen/reply
conversation per client, but it goes into an infinite loop to listen for
more clients as long as this server script runs; the client may run on
a remote machine, or on same computer if it uses 'localhost' for server
"""

"""
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
from socket import * # get socket constructor and constants
myHost = '' # '' = all available interfaces on host
myPort = 50007 # listen on a non-reserved port number
sockobj = socket(AF_INET, SOCK_STREAM) # make a TCP socket object
sockobj.bind((myHost, myPort)) # bind it to server port number
sockobj.listen(5) # listen, allow 5 pending connects

while True: # listen until process killed
    connection, address = sockobj.accept() # wait for next client connect
    print('Server connected by', address) # connection is a new socket
    while True:
        data = connection.recv(1024) # read next line on client socket
        if not data: break # send a reply line to the client
        connection.send(b'Echo=>' + data) # until eof when socket closed
    connection.close()