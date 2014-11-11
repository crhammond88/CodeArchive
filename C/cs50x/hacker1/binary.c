#include <stdio.h>
#include <cs50.h>

int main (void)
{
    int i, count = sizeof(int) * 8;
    bool zero = false;
    do
    {
        printf("Please enter an non-negative interger less than 2 billion:");
        i = GetInt();
    }while(i < 0 || i > 2000000000);

    
    for(int j = count - 1; j >= 0; j--)
    {
        bool isOne = i & (1 << j);
        
        if(isOne)
        {
            zero = true;
            printf("1");
        }
        else if(zero)
            printf("0");
    }
    
    printf("\n");
    
    return 0;
}

