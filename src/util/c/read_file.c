

// C program to implement
// the above approach
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// int string2num(char str[16]) {

// Driver code
int main()
{
    FILE* ptr;
    char ch;
    char num_str[16];
    int i = 0;

    // Opening file in reading mode
    ptr = fopen("/mnt/c/Documents and Settings/janlu/Documents/fun/AoC2023/inputs/2022_day1.txt", "r");

    if (NULL == ptr) {
        printf("file can't be opened \n");
    }
 
    printf("content of this file are \n");

    do {
        ch = fgetc(ptr);
        if (ch == '\n'){
            printf("test");
        }
        // num_str[i] = ch;
        printf("%c", ch);
 
        // Checking if character is not EOF.
        // If it is EOF stop reading.
    } while (ch != EOF);
 
    // Closing the file
    fclose(ptr);
    return 0;
}
