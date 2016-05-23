#!/usr/bin/python3

import cgi
import cgitb

cgitb.enable()

print("Content-Type: text/html")
print()

print("<title>Shibboleth Test</title>")
print("<h1>Shibboleth Test</h1>")
cgi.test()


