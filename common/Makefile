CC=g++
CFLAGS=-c -g -rdynamic -std=c++11 -pthread -isystem /usr/local/include
LDFLAGS=

all: main.o sighandler.o

main.o: main.cpp
	$(CC) $(CFLAGS) main.cpp

sighandler.o: sighandler.c
	$(CC) $(CFLAGS) sighandler.c

clean:
	rm *.o
