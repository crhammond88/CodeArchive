#include <cs50.h>
#include <stdio.h>

#define SIZE 8

bool search(int needle, int haystack[], int size)
{
    int l = 0, h = size;
    while(true)
    {
        int guess = (h+l)/2;
        if(needle == haystack[guess])
            return true;
        else if(needle > haystack[guess])
            l = guess;
        else
            h = guess;
        if(guess == 0 || guess == size)
            return false;
    }
}

int main(void) 
{
    int numbers[SIZE] = { 4, 8, 15, 16, 23, 42, 50, 108 };
    printf("> ");
    int n = GetInt();
    if (search(n, numbers, SIZE))
        printf("YES\n");
    return 0;
}
