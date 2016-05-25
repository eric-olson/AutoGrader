#!/usr/bin/python3

import re

input = open("input")

expr = r"\[(.*)\]\s+\[(.*)\]\s+\[(.*)\]\s+\[(.*)\]\s+\[.*\]"

for line in input:
    result = re.search(expr, line)
    if result:
        g1 = ""
        for w in result.group(1).split(","):
            w = w.strip()
            if w != "":
                g1 = g1 + '"' + w + '", '
        g1 = g1.rstrip(", ")
        g2 = ""
        for w in result.group(2).split(","):
            w = w.strip()
            if w != "":
                g2 = g2 + '"' + w + '", '
        g2 = g2.rstrip(", ")
        g3 = ""
        for w in result.group(3).split(","):
            w = w.strip()
            if w != "":
                g3 = g3 + '"' + w + '", '
        g3 = g3.rstrip(", ")
        g4 = ""
        for w in result.group(4).split(","):
            w = w.strip()
            if w != "":
                g4 = g4 + '"' + w + '", '
        g4 = g4.rstrip(", ")
        print("{{{" + g1 + "}, {" + g2 + "}, {" + g3 + "}}, {" + g4 + "}},")
    else:
        if line.strip() != "":
            print("COULD NOT PARSE NEXT LINE ")
            print(line)
input.close()

