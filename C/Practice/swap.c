/*
*
* Sort function
*
*
*/

#include <stdio.h>
#include <cs50.h>

void swap (int *a, int *b)
{  
     int temp = *a;
     *a = *b;
     *b = temp;
}
     
int main (void)
{
    int x = 5, y = 7;
    
    printf("The numbers are %d and %d!\n", x, y);
    
    swap (&x, &y);
    
    printf("Now the numbers are %d and %d!\n", x, y);
    
    return 0;
}


