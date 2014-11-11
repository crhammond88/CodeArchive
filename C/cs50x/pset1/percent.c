/*
*
* Tells you the percentage relationship of two numbers
*
*/

#include <stdio.h>
#include <cs50.h>

int main (void)
{
    float n,d;
    
    do
    {
    printf("Please enter a non-negative numerator: ");
    n = GetFloat();
    }while(n < 0);
    
    do
    {
    printf("Please enter a positive denominator: ");
    d = GetFloat();
    }while(d < 1);
    
    float a = (n / d) * 100;
    printf("The answer is %.2f%%!\n", a);
    return 0;
}

    
