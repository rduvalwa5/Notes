// Own Header file not mine RDuval

#ifndef __unp_h
#define __unp_h

#include "../config.h"  // get real path
//configuration options for current OS
//../config.h is generated by configure in cygwin

// changes in include files must change in acsite.m4 also
#include <time.h>	 //timeval{} for pselect()
#include <error.h>
#include <fcntl.h>  	//for nonblocking
#include <netdb.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <sys/types.h>		//basic system data types
#include <sys/socket.h>		//basic socket definitions
#include <sys/time.h> 		//timeval{} and select()
#include <sys/stat.h> //for X_xxx file mode constants
#include <sys/uio.h>  //for iovec{} and read/writeev
#include <sys/wait.h>
#include <sys/un.h>  // for UNIX domain sockets

#include <netinet/in.h>  // sockaddr_in{} and other Internet definitions
#include <arpa/inet.h>   // inet(3) functions

ifdef HAVE_SYS_SELECT_H
# include <sys/select.h>  // for convenience 
#endif 

ifdef HAVE_SYS_SYSCTL_H
# include <sys/sysctl.h>  // for convenience 
#endif 

ifdef HAVE_POLL_H
# include <poll.h>  // for convenience 
#endif 

ifdef HAVE_SYS_EVENT_H
# include <sys/event.h>  // for convenience 
#endif 

ifdef HAVE_STRINGS_H
# include <strings.h>  // for convenience 
#endif 

//headers required for socket/files

ifdef HAVE_SYS_IOCTL_H
# include <sys/ioctl.h> 	  		 // for convenience 
#endif 

ifdef HAVE_SYS_FILIO_H  		
# include <sys/filio.h>   			 // for convenience 
#endif 

ifdef HAVE_SYS_SOCKIO_H
# include <sys/sockio.h>   		 // for convenience 
#endif 


ifdef HAVE_PTHREAD_H
# include <pthread.h>  			  // for convenience 
#endif 

ifdef HAVE_NET_IF_DL_H
# include <net/if_dl.h>  			  // for convenience 
#endif 

ifdef HAVE_NETINET_SCTP_H
# include <netinet/sctp.h>  		// for convenience 
#endif 

// OSF/1 disables recv() and send() in sys/socket.h

#ifdef __osf__
#undef recv
#undef send
#define recv(a,b,c,d) recvfrom(a,b,c,d,0,0)
#define send(a,b,c,d) sendto(a,b,c,d,0,0)
#endif

#ifndef INADDR_NONE
#define INADDR_NONE 0xffffffff 		 // 8 fs should be in <netinet/in.h>
#endif

#ifdndef SHUT_RD				//3 POSIX names new
#define SHUT_RD	 0			 //shut down for reading
#define SHUT_WR	 1			 // shut down for writing
#define SHUT_RDWR	 2			 // shut down for reading and writing
#endif

#ifndef INET_ADDRSTRLEN
#define INET_ADDRSTRLEN	16 //  "ddd.ddd.ddd.ddd\0"
#endif

// The following is for IPV6 support it will always allocate an adequately sized buffer without #ifdefs

#ifndef INET6_ADDRSTRLEN
#define INET6_ADDRSTRLEN	46 
//max size of IPV6 address string:
//"xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx"  or "xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:ddd.ddd.ddd.ddd\0"
#endif

//Define bzero() as a macro if it is not in standard C library
#ifndef HAVE_BZERO
#define bzero(ptr,n)  memset(ptr, 0, n)
#endif

//Older resolvers do not have gethostbyname2()
#ifndef HAVE_GETHOSTBYNAME2
#define gethostbyname2(host,family)  gethostbyname((host))
#endif

//Structure returned by receivefrom_flags()
struct unp_in_pktinfo
 {  struct in_addr ipi_addr;  	// dst IPv4 address
    int ipi_ifindex;   		// received interface index
  };

// We need the newer CMSG_LEN()  and CMSG_SPACE()  macros but few mplementations support them today
// These 2 macros really need an ALIGN() macro, but each implementation does this differnectly
#ifndef CMSG_LEN
#define CMSG_LEN(size)  (sizeof(struct cmsghdr) + (size))
#endif

//POSIX requires the SUN_LEN() macro, but not all implementations define it(yet).
// Note that this 4.4 BSD macro works regardless whether there is a length field or not
#ifndef  SUN_LEN
#define SUN_LEN(su) \
   (sizeof(*(su)) - sizeof((su) ->sun_path) + strllen((su)->sun_path))
#endif

//POSIX renames "UNIX domain" as "local IPC."
//Not All systems define AF_LOCAL and PF_LOCAL(yet).
#ifndef AF_LOCAL
#define AF_LOCAL  AF_UNIX
#endif
#ifndef  PF_LOCAL
#define PF_LOCAL  PF_UNIX
#endif

// POSIX requeires that an #include of <poll.h> define INFTIM, but many systems still define it in <sys/stropts.h>
// We do not want to include all the STREAMS stuff if its not needed so we just define INFTIM here.
// This is the standard value but there is no guarantee it is -1
#ifndef  INFTIM
#define INFTIM	(-1)		// infinite poll timeout
#ifdef HAVE_POLL_H
#define INFTIM_UNPH		//test unpxti.h we defined it
#endif
#endif


//Following could be derived from SOMAXCONN in <sys.socket.h>  but many kernals #define it as 5
// while actually supporting many more
#define LISTENQ 	1022 	 //  2nd argument to listen()

// Miscellaneous constants
#define MAXLINE 	4096		// max text line length
#define BUFFSIZE	8192		//buffer size for reads and writes

//Port Numbers that can be used in examples
#define SERV_PORT		9877	//TCP and UDP
#define SERV_PORT_STR	"9877"  //TCP and UDP
#define UNIXSTR_PATH		"/tmp/unix.str"  //Unix domain stream
#define UNIXDG_PATH		"/tmp/unix.dg"  //Unix domain datagram

//Following shortens all the typecasts of pointer arguments
#define SA struct socketaddr

#define HAVE_STRUCT_SOCKADDR_STORAGE
#ifndef  HAVE_STRUCT_SOCKADDR_STORAGE

//RFC 3493 protocol-independent placeholder for socket addresses

#define __SS_MAXSIZE 		128
#define __SS_ALIGNSIZE	(sizeof(int64_t))
#ifdef HAVE_SOCKADDR_SA_LEN
#define __SS_PAD1SIZE (__SS_ALIGNSIZE - sizeof(u_char) - sizeof(sa_family_t))
#else
#define __SS_PAD1SIZE  (__SS_ALIGNSIZE - sizeof(sa_family_t))
#endif

#define __SS_PAD2SIZE  (__SS_MAXSIZE - 2*__SS_ALIGNSIZE)
struct sockaddr_storage 
{  #ifdef HAVE_SOCKADDR_SA_LEN
	u_char ss_len;
#endif
	sa_family_t ss_family;
	char __ss_pad1 [__SS_PAD1SIZE];
	int64_t __ss_align;
	char  __ss_padw[__SS_PAD2SIZE];
};
endif

#define FILE_MODE	(S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
//default file access permissions for new files
#define DIR_MODE	(FILE_MODE | S_IXUSR | S_IXGRP | S_IXOTH)
// default permissions for new directories

tyepdef void Sigfunc (int) // signal handling

#define min(a,b)		((a) < (b) ? (a) : (b))
#define max(a,b)	((a) > (b) ? (a) : (b))

#ifndef HAVE_IF_NAMEINDEX_STRUCT
struct if_nameindex
{  	unsigned int if_index;
	char *if_name;
};
#endif

#ifndef  HAVE_TIMESPEC_STRUCT
struct timespec
{
	time_t  tv_sec;
	long	tv_nsec;
};
#endif












