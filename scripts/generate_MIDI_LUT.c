#include <stdio.h>
#include <inttypes.h>
#include <math.h>

/* The following macros were taken from the Stackoverflow answer in: https://stackoverflow.com/a/53850409 */
#define printbits_n(x,n) for (int i=n;i;i--,putchar('0'|(x>>i)&1))
#define printbits_32(x) printbits_n(x,32)


int main()
{
    const double frequency_resolution = 1099.5116277768;
    const double system_clock = 100000000.0;
    const double phase_width = 36.0;
    for(uint8_t n = 0; n<128 ; n++){
        double tmp = pow(2.0, ((double)n-69.0)/12.0 )*440.0*pow(2.0,phase_width)/system_clock;
        printf("%d, %f\n", n, tmp);
        //printf("	             std_logic_vector( to_unsigned(%d,37) ) when MIDI_NOTE = x\"%02X\" else\n", (int)round(tmp),n);
        printf("	             std_logic_vector( to_unsigned(%d,36) ) when MIDI_NOTE = \"", (int)round(tmp));
        printbits_n(n,7);
        printf("\" else\n");
    }
    
    return 0;
}
                   