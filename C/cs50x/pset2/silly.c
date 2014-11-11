#include <stdio.h>
#include <cs50.h>
#include <string.h>
#include <ctype.h>

int main (void)
{
    printf("What's up?");
    char *input = GetString();
    int count = 0;
    

    
    for(int i = 0; i < strlen(input); i++)
        {
        if(isalpha(input[i]))
            {
            if(count % 2 == 0)
                {
                input[i] += 'A' - 'a';
                }
            count++;
            }
        printf("%c", input[i]);
        }
    printf("\n");
    free(input);
    
    return 0;
}

