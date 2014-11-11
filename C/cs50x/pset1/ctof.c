/*
*
* Converts Celsius to Fahrenheit
*
*/

#include <stdio.h>
#include <cs50.h>

int main (void)
{  
    printf("Enter an interger in Celsius: ");
    int c = GetInt();
    float f = (c * 1.8) + 32;
    printf("C: %d\nF: %.2f\n",c,f);
    return 0;
}
