
#include <8051.h>

enum {
	INS_IDLE, INS_START
};

void terminate() {
	P3 = 0x55;
}

void main () {

	volatile __xdata unsigned char *shared = 
		(volatile __xdata unsigned char *) 0x4000;
	
	
	unsigned i, j;
	for ( i = 0; i < 100; i++ ) 
		for ( j = 0; j < 100; j++ ) 
			shared[i*10+j] = 50;
	
	P0 = INS_START;
	
	while ( P1 );
	
	terminate();

}

