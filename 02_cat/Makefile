cat: cat.o
	ld $^ -o $@

cat.o: cat.S
	as $^ -o $@

.PHONY: clean
clean:
	rm cat cat.o

