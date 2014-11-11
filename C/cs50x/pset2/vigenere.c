#include <stdio.h>
#include <cs50.h>
#include <string.h>
#include <ctype.h>


/*prototypes*/
bool checkalpha (char* s);
int makekeys (char* key, int* keys[]);



int main (int argc, char* argv[])
{
    /*check for argv1 as a word*/
    if(argc != 2 || atoi(argv[1]) > 0)
    {
        printf("Please enter a single word.\n");
        return 1;
    }
    
    /*check for alpha characters*/
    if(checkalpha(argv[1]) == false)
    {
        printf("Must be only alphabetical characters!\n");
        return 1;
    }
    
    char* key = argv[1];     /*transfer argv1 to key*/
    char* mes = GetString(); /*message to be ciphered*/  
    int count = 0; /*for the key  skip over spaces and special characters*/
    
    /*encrypt*/
    for(int i = 0, n = strlen(mes); i < n; i++)
    {
        if(isalpha(mes[i]))
        {
            if(isupper(mes[i]))
            {
                mes[i] = (((mes[i] - 'A') + (toupper(key[count]) - 'A')) % 26) + 'A';
                count = (count + 1) % (strlen(key));
            }
            else
            {
                mes[i] = (((mes[i] - 'a') + (tolower(key[count]) - 'a')) % 26) + 'a';
                count = (count + 1) % (strlen(key));
            }
        }
        printf("%c", mes[i]);
    }
    
    printf("\n");

    
    free(mes);   

    return 0;
}





bool checkalpha (char* s)
{
    for(int i = 0, n = strlen(s); i < n; i++)
    {
        if (isalpha(s[i]) == false)
            return false;
    }
    return true;
}



