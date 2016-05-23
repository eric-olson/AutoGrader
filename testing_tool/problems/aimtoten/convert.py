#!/usr/bin/python3

import re

expr = r"\[(.*)\]\s+([0-9]+)"

input = open("input")

for line in input:
    result = re.search(expr, line)
    if result:
        print("\t{{"+result.group(1)+"},", result.group(2)+"},")

input.close()

