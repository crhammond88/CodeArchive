/*
*
* Reports to the user the number of coins necessary to dispense an inputted amount of change.
*
*/

#include <stdio.h>
#include <cs50.h>

int main (void)
{
    float cents;
    int count = 0;
    int array[] = {25,10,5,1};
    
    do
    {
        printf("How much change is owed?");
        cents = GetFloat();
    }while(cents < 0.00);
    
    int rounded = (cents + 0.005) * 100;
    
    for(int i = 0; i < 5; i++)
    {
        count += rounded / (array[i]);
        rounded %= (array[i]);
    }
    
    printf("%d\n", count);
    
    return 0;
}
