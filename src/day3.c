#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h> 
#include <math.h>

#define N_ROWS 140
#define N_COLS 140

int str2int(char str[16], int len){
    int num = 0;
    int pow10 = pow(10, len-1);

    for (int i=0; i<len; i++) {
        num += pow10*(str[i] - '0');
        pow10 = pow10/10;
    }
    return num;
}

bool has_sym_adj(char lines[N_ROWS][N_COLS+1], int jl, int ju, int il, int iu){
    for (int i = il; i<=iu; i++){
        for (int j = jl; j<=ju; j++) {
            if (lines[i][j] != '.' && (lines[i][j] < '0' || lines[i][j] > '9')) {
                return true;
            }
        }
    }
    return false;
}

// Driver code
int main()
{
    FILE* ptr;
    char ch;
    int i = 0;
    int j = 0;
    int k = 0;

    int jl;
    int ju;
    int il;
    int iu;
    int sum = 0;
    int num;
    int num_start;
    char lines[N_ROWS][N_COLS+1];
    char str_num[16];
    bool reading_num = false;
    bool sym_adj = false;


    // Opening file in reading mode
    ptr = fopen("/home/luca/Desktop/fun/AoC2023/inputs/day3.txt", "r");

    if (NULL == ptr) {
        printf("file can't be opened \n");
    }
 
    do {
        ch = fgetc(ptr);
        lines[i][j] = ch;
        if (ch == '\n') {
            lines[i][j] = '\0';
            printf("%d ,%d, %d\n", i, j, lines[i][j-1]);
            i++;
            j=0;
        }
        j++;

    } while (ch != EOF);
    // printf("%ld\n %s", strlen(lines[0]+1),lines[0]+1);
    // return 0;

    for (int i = 0; i<N_ROWS; i++){
        reading_num = false;
        for (int j = 0; j<N_COLS+2; j++) {
            ch = lines[i][j];
            if (reading_num) {
                if (!(ch >= '0' && ch <= '9' ) || j == N_COLS){
                    if (i == 0) {
                        il = i;
                        iu = i+1;
                    } else if (i == N_ROWS) {
                        il = i-1;
                        iu = i;
                    } else {
                        il = i-1;
                        iu = i+1;
                    }

                    if (j == N_COLS) {
                        ju = j+1;
                    } else {
                        ju = j+1;
                    }

                    if (str2int(lines[i]+jl+1, j-jl-1) == 543) {
                        printf("%s\n", lines[i]+jl-1);
                        printf("%d\n", str2int(lines[i]+jl+1, j-jl-1));
                        printf("%d, %d, %d, %d, %d\n", jl, j, ju, il, iu);
                        return 0;
                    }

                    if (has_sym_adj(lines, jl=jl-1, ju=ju, il=il, iu = iu)) {
                        // printf("%s\n", lines[i]+jl-1);
                        // printf("%d\n", str2int(lines[i]+jl+1, j-jl-1));
                        // printf("%d, %d, %d, %d, %d\n", jl, j, ju, il, iu);
                        // return 0;
                        sum += str2int(lines[i]+jl+1, j-jl-1);
                        printf("%d\n", str2int(lines[i]+jl+1, j-jl-1));
                    }
                    reading_num = false;
                }
            } else {
                if (ch >= '0' && ch <= '9' ){
                    reading_num = true;
                    jl = j;
                }
            }
            // if (i == 5) {
            //     return 0;
            // }
        }
    }
    printf("Part 1 solution: %d\n", sum);

    fclose(ptr);
    return 0;
}
