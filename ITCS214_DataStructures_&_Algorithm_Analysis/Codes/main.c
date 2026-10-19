#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

int main() {
    int start=0, step=0, stop=0;
    scanf("%d %d %d", start, step, stop);

    while (start < stop) {
        start += step;
        printf("%d", start);
    }
    /* Enter your code here. Read input from STDIN. Print output to STDOUT */    
    return 0;
}
