CC      = gcc
CFLAGS  = -Wall -Wextra

scanner: lex.yy.c scanner.c scanner.h
	$(CC) $(CFLAGS) -o scanner lex.yy.c scanner.c

lex.yy.c: scanner.l scanner.h
	flex scanner.l

test: scanner
	./scanner < demo.lang

clean:
	rm -f lex.yy.c scanner