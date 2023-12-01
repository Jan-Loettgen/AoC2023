#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int str2int(char str[16]){
    int num = 0;
    int len = strlen(str);
    int pow10 = pow(10, len-1);

    for (int i=0; i<len; i++) {
        num += pow10*(str[i] - '0');
        pow10 = pow10/10;
    }
    return num;
}

// Driver code
int main()
{
    FILE* ptr;
    char ch;
    char ch_prev;
    char num_str[16];
    int i = 0;
    int j = 0;
    int nums[10000];
    int starts_idx[10000];
    int sum = 0;
    int max_sums[3];

    // Opening file in reading mode
    ptr = fopen("/home/luca/Desktop/fun/AoC2023/inputs/2022_day1.txt", "r");

    if (NULL == ptr) {
        printf("file can't be opened \n");
    }
 
    ch_prev = '\n';
    starts_idx[0] = 0;
    max_sums[0] = 0;
    max_sums[1] = 0;
    max_sums[2] = 0;
    do {
        ch = fgetc(ptr);
        if (ch == '\n' && (ch_prev == '\n')){
            starts_idx[j] = i;

            if (sum > max_sums[0]) {
                max_sums[2] = max_sums[1];
                max_sums[1] = max_sums[0];
                max_sums[0] = sum;
            } else if (sum > max_sums[1]) {
                max_sums[2] = max_sums[1];
                max_sums[1] = sum;
            } else if (sum > max_sums[2]) {
                max_sums[2] = sum;
            }
            sum = 0;

        } else if (ch == '\n') {
            num_str[j] = '\0';
            nums[i] = str2int(num_str);
            sum += nums[i];
            j = 0;
            i++;
        } else {
            num_str[j] = ch;
            j++;
        }
        ch_prev = ch;
    } while (ch != EOF);
    printf("Part 1 solution: %d\n", max_sums[0]);
    printf("Part 2 solution: %d\n", max_sums[0] + max_sums[1] + max_sums[2]);

    // Closing the file
    fclose(ptr);
    return 0;
}
