#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h> 
#include <math.h>

int str2int(char str[16], int len){
    int num = 0;
    int pow10 = pow(10, len-1);

    for (int i=0; i<len; i++) {
        num += pow10*(str[i] - '0');
        pow10 = pow10/10;
    }
    return num;
}

int N_RED = 12;
int N_GREEN = 13;
int N_BLUE = 14;

// Driver code
int main()
{
    FILE* ptr;
    char ch;
    int i = 1;
    int j = 0;
    int last_space = 0;
    int sum = 0;
    int sum2 = 0;
    char line[320];
    bool game_pos = true;

    int n = 0;

    int min_r = 0;
    int min_b = 0;
    int min_g = 0;

    // Opening file in reading mode
    ptr = fopen("/home/luca/Desktop/fun/AoC2023/inputs/day2.txt", "r");

    if (NULL == ptr) {
        printf("file can't be opened \n");
    }
 
    do {
        ch = fgetc(ptr);
        line[j] = ch;

        if (ch == 'r' && line[j-1] == ' ') {
            n = str2int(line+last_space+1, j-last_space-2);

            if (n > min_r) {
                min_r = n;
            }
            if (n > N_RED) {
                game_pos = false;
            }
        } else if (ch == 'g' && line[j-1] == ' ') {
            n = str2int(line+last_space+1, j-last_space-2);

            if (n > min_g) {
                min_g= n;
            }
            if (n > N_GREEN) {
                game_pos = false;
            }
        } else if (ch == 'b' && line[j-1] == ' ') {
            n = str2int(line+last_space+1, j-last_space-2);

            if (n > min_b) {
                min_b = n;
            }
            if (n > N_BLUE) {
                game_pos = false;
            }
        }

        //first occurence of space
        if (j > 4 && line[j-2] == ' '){
            last_space = j-2;
        }

        if (ch == '\n') {
            line[j] = '\0';

            if (game_pos) {
                sum += i;
            }

            sum2 += min_r*min_b*min_g;

            game_pos = true;
            i++;
            j=0;

            min_r = 0;
            min_b = 0;
            min_g = 0;
        }
        line[j] = ch;
        j++;
    } while (ch != EOF);
    printf("Part 1 solution: %d\n", sum);
    printf("Part 2 solution: %d\n", sum2);


    fclose(ptr);
    return 0;
}
