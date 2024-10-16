#include <stdint.h>
#include <stdio.h>

int N = 5;
int K = 4;

int dot_product(uint64_t* l, uint64_t* r, const uint64_t len);

int main() {
    uint64_t v1[] = {1, 2, 3, 4, 5};
    uint64_t v2[] = {2, 2, 2, 2, 2};
    uint64_t v3[] = {2, 2, 2, 2, 2};

    int res = dot_product(v1, v2, N) & 0xff;

    printf("%x\n", res);
    printf("%d\n", res);
}
