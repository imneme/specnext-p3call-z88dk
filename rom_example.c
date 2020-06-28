#include <stdio.h>
#include <stdlib.h>
#include <zxn_rom3call.h>

void* get_sp(int i)
{
    return (void*) &i;
}

int main()
{
    int i;
    short free_mem;
    printf("Hello World\n");
    for (i = 0; i < 256; ++i)
	zxn_rom3_plot_sub(i,i/2);
    zxn_rom3_beeper(0x0085, 0x066a);

    // This value is naccurate because the stack is moved above RAMTOP
    free_mem = 65535 - (unsigned short)zxn_rom3_test_room(0);
    // Correct it (assuming org 32768).
    free_mem -= ((unsigned short)get_sp(0)) - 32768;
    printf("%u bytes free for BASIC.\n", free_mem);
    return 0;
}

