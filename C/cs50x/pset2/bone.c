#include <stdio.h>

int main (void)
{
    char *knick = "Knick-knack paddywhack, give your dog a bone\nThis old man came rolling home!\n\n";
    
    char *count[10] = {"one","two","three","four","five","six","seven","eight","nine","ten"};
    
    char *start = "This old man, he played";
    
    char *he = "He played knick-knack";
    
    char *play[10] = {"on my thumb","on my shoe","on my knee","on my door","on my thigh","on my sticks","up in heaven","on my gate","on my spine","once again"};
    
    printf("\n");
    
    for(int i = 0; i < 10; i++)
        printf("%s %s\n%s %s\n%s",start,count[i],he,play[i],knick);
        
    return 0;
}


