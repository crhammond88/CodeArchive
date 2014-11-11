#include <stdio.h>
#include <cs50.h>

int main (void)
{
    char letter;
    do
    {
        printf("Please enter a lowercase letter:");
        letter = GetChar();
    }while(letter < 'a' || letter > 'z');
    
    char upper = letter & ('_');

    printf("%c\n", upper);
    
    return 0;
}
