#include <stdint.h>

// Externally declared functions. Resolved at link time.
void set_paging_structures(void);
void set_long_mode(void);

// Module functions
int strlen(const char *str);

// 64-bit LM entry point
void print(void);


void main()
{
	char *video_memory = (char *) 0xb8000;
	*video_memory = 'X';

	set_paging_structures();
	asm volatile ("mov %0, %%edi;" : : "g" (print));
	set_long_mode();
}

void print()
{
	char *msg = "Successfully landed in 64-bit Long Mode";
	char *video_memory = (char *) 0xb8000;
	for (int i = 0; i < strlen(msg); i++) {
		video_memory[i*2] = msg[i]; 
	}
	asm volatile ("hlt");
}

int strlen(const char *str) {
	int i = 0;

	while (str[i] != 0x00)
		i++;

	return i;
}
