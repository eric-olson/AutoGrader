#!/usr/bin/python3

import re

input = open("input")

expr = r"\s*\[(.*)\]\s+([0-9]+)"

for line in input:
    result = re.search(expr, line)
    if result:
        print("{{" + result.group(1) + "}, " + result.group(2) + "},")
    else:
        if line.strip() != "":
            print("COULD NOT PARSE NEXT LINE ")
            print(line)
input.close()

