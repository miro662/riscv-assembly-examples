#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <time.h>

extern void quicksort(int64_t* args, size_t len);

#define ARRAY_SIZE 65536

void print_array(int64_t* array, size_t len) {
	size_t i;
	for (i = 0; i < len; ++i) {
		if (len - i == 1) {
			printf("%li", array[i]);
		} else {
			printf("%li, ", array[i]);
		}
	}
	printf("\n");
}

void fill_with_random(int64_t* array, size_t len, int64_t max) {
	size_t i;
	for (i = 0; i < len; ++i) {
		array[i] = rand() % max + 1;
	}
}

int main(void) {
	srand(time(NULL));
	int64_t* array = calloc(ARRAY_SIZE, sizeof(int64_t));
	fill_with_random(array, ARRAY_SIZE, 1 << 16);

	printf("before: ");
	print_array(array, ARRAY_SIZE);
		
	quicksort(array, ARRAY_SIZE);
	
	printf("after:  ");
	print_array(array, ARRAY_SIZE);
	free(array);
	return 0;
}
