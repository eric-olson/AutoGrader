#!/usr/bin/python3

input = open("input")

for line in input:
	s = line.split()
	print("\t{{" + s[0] + "," + s[1] + "}," + s[2] + "},")

input.close()

