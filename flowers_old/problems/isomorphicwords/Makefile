CC=g++
CFLAGS=-std=c++11 -pthread -isystem /usr/local/include -I../common/
LDFLAGS=

tests: tests.cpp solution.cpp
	$(CC) $(CFLAGS) -o tests tests.cpp ../common/main.o /usr/local/lib/gtest/libgtest.a

