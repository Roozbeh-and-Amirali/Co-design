#include <stdio.h>

volatile unsigned int *req = (unsigned int *) 0x80000000;
volatile unsigned int *ack = (unsigned int *) 0x80000004;

void sync1() {
	*req = 1;
	while ( *ack == 0 ) 
		;
}

void sync0() {
	*req = 0;
	while ( *ack == 1 )
		;
}

int main () {

	volatile unsigned int *di = (unsigned int *) 0x80000008;
	volatile unsigned int *ot = (unsigned int *) 0x8000000C;
	
	// p and q
	*di = 13;
	sync1();
	*di = 17;
	sync0();
	
	// m
	*di = 10;
	sync1();
	
	sync0();
	printf("C: %ld\n", *ot);
	
	sync1();
	printf("M: %ld\n", *ot);
	
	sync0();

}

