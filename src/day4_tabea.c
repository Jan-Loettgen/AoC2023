#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main() {
    FILE* f = fopen("/home/luca/Desktop/fun/AoC2023/inputs/day4.txt", "r");
    if (f == NULL) {
        perror("Error opening file");
        return 1;
    }

    int NumWin = 10;
    int NumHave = 25;
    int NumCards = 200;
    int winning[NumWin];
    int have[NumHave];
    long copies[NumCards];

    for (int i = 0; i < NumCards; i++) {
        copies[i] = 1;
    }
    int cardNumber = 1;
    char line[5000];
    while (fgets(line, sizeof(line), f)) {
        char *colon = strchr(line, ':');
        char *pipe = strchr(line, '|');
        //cardNumber = atoi(colon + 2) - 1;

        char *token = strtok(colon + 2, " ");
        int a_count = 0;
        while (token != NULL && token < pipe) {
            winning[a_count++] = atoi(token);
            token = strtok(NULL, " ");
        }

        token = strtok(pipe + 2, " ");
        int b_count = 0;
        while (token != NULL) {
            have[b_count++] = atoi(token);
            token = strtok(NULL, " ");
        }

        int score = 0;
        for (int i = 0; i < a_count; i++) {
            if (cardNumber == 1) {
            printf("%d\n", winning[i]);
            }
            for (int j = 0; j < b_count; j++) {
                if (winning[i] == have[j]) {
                    score++;
                }
            }
        }

        printf("Score %d, cardNumber %d\n", score, cardNumber);

        for (int i = 1; i <= score; i++) {
            copies[cardNumber + i-1] += copies[cardNumber -1];
        }
        cardNumber++;
    }

    long sum = 0;
    for (int i = 0; i < NumCards; i++) {
        //printf("%ld\n", copies[i]);
        sum += copies[i];
    }

    printf("Total Sum: %ld\n", sum);
    fclose(f);
    return 0;
}