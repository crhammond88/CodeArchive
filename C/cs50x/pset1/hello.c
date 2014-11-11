#include <stdio.h>

int main (void)
{
    char words[10] = {'h','e','l','l','o','w','o','r','l','d'};
    for (int i = 0; i < 10; i++)
    { 
        printf("%c", words[i]);
        if (i == 4)
            printf(", ");
    }
    printf("\n");
    return 0;
}
    
 
