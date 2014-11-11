/*
*
*    Sorts numbers
*
*   By Chris Hammond
*
*/

#include <stdio.h>
#include <cs50.h>

//prototypes
void swap (int *a, int *b);

int main (void)
{  
    int sample[] = {8,5,6,3,1,2,7,4};
    
    //prints unsorted sample
    for (int i = 0; i < 8; i++)
        printf("%d", sample[i]);
    printf("\n");
        
    //bubble sorts numbers

    //iterates passes through list until there are no more swaps executed
    for (int counter = 1, i = 0; i < 8 && counter != 0; i++)
    {
        //set counter to 0 for termination condition
        counter = 0;
        
        //iterates through list to perform swaps
        for (int j = 0; j < 7; j++)
        {   
            //compares ints
            if (sample[j] > sample[j + 1])
            {
                //swaps ints
                swap(&sample[j], &sample[j + 1]);
                //prevents termination condition
                counter++;
            }
        }
     }   
    //prints sorted sample
    for (int i = 0; i < 8; i++)
        printf("%d", sample[i]);
    printf("\n");
        
    return 0;
}

void swap (int *a, int *b)
{  
     int temp = *a;
     *a = *b;
     *b = temp;
}
     
