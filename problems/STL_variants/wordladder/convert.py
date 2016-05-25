#!/usr/bin/python3

import re

input = open("input")

expr = r"\[(.*)\]\s+([a-z]+)\s+([a-z]+)\s+\[([0-9]+),"

for line in input:
    result = re.search(expr, line)
    if result:
        g1 = ""
        for w in result.group(1).split(","):
            w = w.strip()
            if w != "":
                g1 = g1 + '"' + w + '", '
        g1 = g1.rstrip(", ")
        print("{{{" + g1 + "}, \"" + result.group(2) + "\", \"" + result.group(3) + "\"}, " + result.group(4) + "},")
    else:
        if line.strip() != "":
            print("COULD NOT PARSE NEXT LINE ")
            print(line)
input.close()

