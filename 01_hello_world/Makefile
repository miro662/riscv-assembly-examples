main.elf: main.o
	ld $^ -o $@

main.o: main.S
	as $^ -o $@

.PHONY: clean
clean:
	rm main.elf main.o

