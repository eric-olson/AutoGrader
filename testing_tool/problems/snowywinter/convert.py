#!/usr/bin/python3

import re

expr = r"\[(.*)\]\s+\[(.*)\]\s+([0-9]+)\s+[0-9]+"

input = open("input")

line = ""
for ln in input:
    line = line + " " + ln.rstrip()
    result = re.search(expr, line)
#    print(line)
    if result:
#        print("FOUND:")
        print("\t{{{"+result.group(1)+"}, {"+result.group(2)+"}},",result.group(3)+"},")
        line = ""

input.close()

