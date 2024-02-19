CRTI_PATH = /usr/lib/riscv64-linux-gnu/crt0.o

quicksort: main.o quicksort.o
	gcc $^ -o $@

quicksort.o: quicksort.S
	as $^ -o $@

main.o: main.c
	gcc $^ -c -o $@

.PHONY: clean
clean:
	rm main.o quicksort quicksort.o

