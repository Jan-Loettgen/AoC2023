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
    char num_str[3];
    int i = 0;
    int j = 0;
    int i_low = 1000;
    int i_high = 0;
    int str_len = 0;
    int nums[10000];
    int sum = 0;
    char line[160];
    char num_strs[10][16] = {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};
    char *str_ptr;

    // Opening file in reading mode
    ptr = fopen("/home/luca/Desktop/fun/AoC2023/inputs/day1.txt", "r");

    if (NULL == ptr) {
        printf("file can't be opened \n");
    }
 
    do {
        ch = fgetc(ptr);
         if (ch == '\n') {
            line[j] = '\0';
            if (i_low == i_high) {
                num_str[1] = num_str[0];
            }

            for (int k=0; k<10; k++){
                str_ptr = strstr(line, num_strs[k]);
                
                while (str_ptr != NULL){
                    str_len = strlen(line) - strlen(str_ptr);    

                    if (str_len < i_low) {
                        if (i_low == i_high) {
                            num_str[1] = num_str[0];
                        }
                        num_str[0] = k +'0';
                        i_low = str_len;
                    } else if (str_len+1 >= i_high) {
                        num_str[1] = k + '0';
                        i_high = str_len;
                    }
                    str_ptr = strstr(str_ptr+strlen(num_strs[k]), num_strs[k]);
                }
            }

            sum += str2int(num_str);

            i = 0;
            j = 0;
            i_low = 1000;
            i_high = 0;
        } else if (i == 0 && ch - '0' >= 0 && ch - '9' <= 9) {
                num_str[0] = ch;
                i_low = j;
                i_high = j;
                i++;
        } else if (i >= 1 && ch - '0' >= 0 && ch - '9' <= 9) {
                num_str[1] = ch;
                i_high = j;
        }
        line[j] = ch;
        j++;
    } while (ch != EOF);
    printf("Solution: %d\n", sum);
    fclose(ptr);
    return 0;
}
