/*
*
* Builds a half pyramid.
*
*/

#include <stdio.h>
#include <cs50.h>

int main (void)
{
    int height;
    
    do
    {
        printf("Please enter the desired height of your pyramid:");
        height = GetInt();
    }while(height < 0 || height > 23);
    
    if(height == 0)
        return 0;
    
    for(int i = height - 1, j = 2; i > -1; i--, j++)  
    {
        for(int k = i; k > 0; k--)
            printf(" ");
        for(int k = j; k > 0; k--)
            printf("#");
        printf("\n");
    }   
    return 0;
}
