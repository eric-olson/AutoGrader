#!/usr/bin/python3

import cgi

print("Content-Type: text/html")
print()

form = cgi.FieldStorage()
if "problem" not in form:
	print("<html><body>")
	print("<h2>Error: no problem specified.</h2>")
	print("</body></html>")
else:
	fd = open("request_template.html");
	s = fd.read()
	print(s.replace("ZZZ", form["problem"].value))

