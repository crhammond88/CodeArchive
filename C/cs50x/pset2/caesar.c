#include <stdio.h>
#include <cs50.h>
#include <string.h>
#include <ctype.h>


int main (int argc, char* argv[])
{
    if(argc != 2 || atoi(argv[1]) < 0 || (isdigit(*argv[1]) == false && (atoi(argv[1]) < 10)))
    {
        printf("Please input a non-negative interger!\n");
        return 1;
    }

    int key = atoi(argv[1]) % 26; /*create key*/
    
    char* mes = GetString(); /*message to be ciphered*/
    
    for(int i = 0, n = strlen(mes); i < n; i++)
    {
        if(isalpha(mes[i]))
        {
            if(isupper(mes[i]))
            {
                mes[i] = (((mes[i] - 'A')+ key) % 26) + 'A';
            }
            else
            {
                mes[i] = (((mes[i] - 'a')+ key) % 26) + 'a';
            }
        }
        printf("%c", mes[i]);
    }
    
    printf("\n");

    
    free(mes);
    return 0;
}
