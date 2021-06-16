
#include <8051.h>

#include <stdlib.h>

enum {
	INS_IDLE, INS_START
};

void terminate() {
	P3 = 0x55;
}

void main () {

	volatile __xdata unsigned char *shared = 
		(volatile __xdata unsigned char *) 0x4000;
		
	unsigned image_counter;
	for ( image_counter = 0; image_counter < 8; image_counter++ ) {
	
		unsigned i, j;
		for ( i = 0; i < 10; i++ ) 
			for ( j = 0; j < 10; j++ ) 
				shared[i*10+j] = rand() % 256;
		
		P0 = INS_START;
		P0 = INS_IDLE;
	
		while ( P1 == 0 );
	
	}
	
	terminate();

}

