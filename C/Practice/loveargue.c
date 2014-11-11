/**
*
* This program loves you more.
* 
* By Chris Hammond
*
**/

#include <cs50.h>
#include <stdio.h>

//prototypes
void asterisks();

int main (void)
{
    char choice;
    do
    {
        //starts conversation
        asterisks();
        printf ("I love you!\n");
        asterisks();
        //provides choices
        printf ("A. I love you too!\nB. I love you more!\nC. I love you most!\nPlease choose A,B or C:");
        //sets variable choice
        choice = GetChar();  
        //
        choice = choice | ('a' - 'A');

        if (choice == 'a')
        {
            asterisks();
            printf ("Mwah!\n");
            asterisks();
            return 0;
        }
        else if (choice == 'b')
        {    
            char choice2;
            do
            {
                printf ("Nope, I love you more!\nPlease press A to argue or B to surrender:") ;
                choice2 = GetChar();
                choice2 = choice2 | ('a' - 'A');
            }
            while (choice2 != 'b');
                asterisks();
                printf ("Told you so!\n");
                asterisks();
                return 0;
         }
        else if (choice == 'c')
        {
            char choice3;
            do
            {
                printf ("Nope, I love you most!\nPlease press A to argue or B to surrender:") ;
                choice3 = GetChar();
                choice3 = choice3 | ('a' - 'A');
            }
            while (choice3 != 'b');
                asterisks();
                printf("Told you so!\n");   
                asterisks();
                return 0;
        }      
        else
            printf("Wrong letter!\n");
    }
    while (choice > 'c' || choice < 'a');    
}  
        
void asterisks(void)
{
    for (int i = 0; i < 5; i++)
        {
        for (int j = 0; j < 30; j++)
            {
            printf ("*");
            }
         printf ("\n");
         }   
}
