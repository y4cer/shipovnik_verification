#include <stdio.h>

int N = 5;
int K = 4;

int* func(int* v1);

int main() {
    int v1[] = {1, 2, 3, 4, 5};
    int v2[] = {2, 2, 2, 2, 2};
    int v3[] = {2, 2, 2, 2, 2};
    int* res;

    res = func(v1);
    printf("%p\n", res);
    printf("%d\n", *res);
}
