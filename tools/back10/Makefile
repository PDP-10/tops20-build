BACK10=back10.o

CC?= gcc

.c.o:
	$(CC) -g -c $*.c

all:	back10

back10: $(BACK10)
	$(CC) -o back10 $(BACK10)

tar:
	tar -cf back10.tar Makefile back10.c back10.h
