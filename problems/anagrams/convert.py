#!/usr/bin/python3

import re

input = open("input")

expr = r"\s*\[(.*)\]\s*\[(.*)\]\s*\[(.*)\]"

cline = ""
for line in input:
    cline = cline + line
    result = re.search(expr, cline)
    if result:
        print("{{" + result.group(1) + "}, {" + result.group(2) + "}},")
        cline = ""
 
input.close()

