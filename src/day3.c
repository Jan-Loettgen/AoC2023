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

int find_nums(int nums[N_ROWS][N_COLS+1], int i,int j){
    int count = 0;
    int dup = false;
    int nums_found[9];

    for (int a = -1; a<2; a++) {
        for (int b = -1; b<2; b++) {
            if (nums[i + a][j + b] != 0 ) {
                printf("%d\n", nums[i + a][j + b]);
                dup = false;
                for (int c = 0; c<count;c++){
                    if (nums[i + a][j + b] == nums_found[c]) {
                        dup = true;
                    }
                }
                if (!dup){
                    nums_found[count] =  nums[i + a][j + b];
                    count++;
                }
            } 

        }
    }
    if (count == 2) {
        return nums_found[0] * nums_found[1];
    } else {
        return 0;
    }
}


// Driver code
int main()
{
    FILE* ptr;
    char ch;
    int i = 0;
    int j = 0;
    int k = 0;

    int jstart;
    int jl;
    int ju;
    int il;
    int iu;
    int sum = 0;
    int num;
    int num_start;
    char lines[N_ROWS][N_COLS+1];
    int nums[N_ROWS][N_COLS+1];

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
            i++;
            j=-1;
        }
        j++;

    } while (ch != EOF);

    for (int i = 0; i<N_ROWS; i++){
        for (int j = 0; j<N_COLS+1; j++) {
            nums[i][j] = 0;
        }
    }

    for (int i = 0; i<N_ROWS; i++){
        reading_num = false;
        for (int j = 0; j<N_COLS+1; j++) {
            ch = lines[i][j];

            if (ch == '*'){

            }



            if (reading_num) {
                if (!(ch >= '0' && ch <= '9' ) || j == N_COLS){


                    for (int f= 0; f <(j-jstart); f++) {
                        nums[i][j-f-1] = str2int(lines[i]+jstart, j-jstart);
                    }

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

                    if (jstart == 0) {
                        jl = 0;
                    } else {
                        jl = jstart-1;
                    }
                    
                    if (j == N_COLS) {
                        ju = j-1;
                    } else {
                        ju = j;
                    }

                    if (has_sym_adj(lines, jl=jl, ju=ju, il=il, iu = iu)) {
                        sum += str2int(lines[i]+jstart, j-jstart);
                        printf("%d\n", str2int(lines[i]+jstart, j-jstart));
                    }
                    reading_num = false;
                }
            } else {
                if (ch >= '0' && ch <= '9' ){
                    reading_num = true;
                    jstart = j;
                }
            }
        }

    }
    int sum2 = 0;
    for (int i = 0; i<N_ROWS; i++){
        for (int j = 0; j<N_COLS+1; j++) {
            ch = lines[i][j];
            if (ch == '*') {
                sum2 += find_nums(nums, i, j);              
            }
        }
    }

    printf("Part 1 solution: %d\n", sum);
    printf("Part 1 solution: %d\n", sum2);

    fclose(ptr);
    return 0;
}
