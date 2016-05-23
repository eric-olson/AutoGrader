#!/usr/bin/python3

import cgi
import subprocess
import os
import tempfile
import shutil
import multiprocessing
from lxml import etree

# global settings
NAME="CSCI Grader"
COMMONDIR   = '/home/grader/common'
PROBLEMSDIR = '/home/grader/problems'
TIMEOUT = 10.0

# begin http response
print("Content-Type: text/html")
print()
print("<html>")

# before calling this function, ensure that proper head has been created
# and that the body element has been opened
def early_exit():
    print("</body>")
    print("</html>")
    exit()

# get problem and user submitted file
form = cgi.FieldStorage()
PROBLEM = form.getfirst("problem")
if PROBLEM == None:
    print("<head><title>", NAME, ": Script error!</title></head>")
    print("<b>ERROR: No problem specified!</b>")
    early_exit()

PROBLEM = PROBLEM.lower()
print("<head><title>")
print(NAME, ": ", PROBLEM, " test results")
print("</title></head>")
print("<body>")
print("<h1>")
print(NAME, ": ", PROBLEM, " test results")
print("</h1>")


SOURCE = form.getfirst("source_file")
if SOURCE == None or SOURCE == '':
    printf("<b>ERROR: No source file uploaded!")
    early_exit()

#print("<br/><b>file uploaded:</b> " + str(len(SOURCE)) + " bytes")

CWD = PROBLEMSDIR + '/' + PROBLEM

# setup temp environment
tmp = tempfile.TemporaryDirectory(dir='/tmp')
TEMPDIR = tmp.name
#print("<br/><b>temp directory:</b> " + TEMPDIR)

try:
    source_fd = open(TEMPDIR + '/solution.cpp', "w+b")
    source_fd.write(SOURCE)
    source_fd.close()
except Exception as e:
    print("<br/><b>ERROR:</b><br/><pre>")
    print(e)
    print("</pre>")
    early_exit()

shutil.copy(CWD + '/tests.cpp', TEMPDIR);
shutil.copy(COMMONDIR + '/main.o', TEMPDIR);
shutil.copy(COMMONDIR + '/assoc.h', TEMPDIR);

os.chdir(TEMPDIR)

# build tests
CPPARGS = ['g++', '-o', 'tests', '-I.', '-std=c++11', '-pthread']
CPPARGS = CPPARGS + ['tests.cpp', 'main.o', '/usr/local/lib/gtest/libgtest.a']

try:
    compile_output = subprocess.check_output(CPPARGS, stderr=subprocess.STDOUT, universal_newlines=True)
    if compile_output != '':
        print("<h4>Compiler provided output:</h4>")
        print(compile_output)
    else:
        print("<h4>Compile succeeded.</h4>")
except subprocess.CalledProcessError as err:
    print("<br/><b>You have compile errors:</b><br/><pre>")
    print(err.output)
    print("</pre>")
    early_exit()

# setup chroot environment
for d in ['lib', 'lib64', 'usr']:
    shutil.copytree(COMMONDIR + '/tmpenv/' + d, TEMPDIR + '/' + d)

shutil.copy(COMMONDIR + '/gtest.xslt', TEMPDIR);

# run tests in a separate process with chroot
def runtests(dir):
    os.chroot(dir)
    printed_error = False 
    try:
        exec_output = subprocess.check_output(['./tests', '--gtest_output=xml'], stderr=subprocess.STDOUT, timeout=TIMEOUT, universal_newlines=True)
        print("<!--")
        print(exec_output)
        print("-->")
    except subprocess.CalledProcessError as err:
        print("<!--")
        print(err.output)
        print("-->")
        if "SIGSEGV" in err.output:
            print("<h2 style='color:red'>Oops! You appear to have a memory exception error (segmentation fault).</h2>")
            printed_error = True
        elif "SIGFPE" in err.output:
            print("<h2 style='color:red'>Oops! You appear to have a floating point error (divide by zero?)</h2>")
            printed_error = True
    except subprocess.TimeoutExpired:
        print('<h2 style="color:red">Execution timed out: infinite loop?</h2>')
        printed_error = True

    if os.path.exists("test_detail.xml"):
        xml = etree.parse("test_detail.xml")
        xslt = etree.parse("gtest.xslt")
        transform = etree.XSLT(xslt)
        print(str(transform(xml)))
        print()
    elif not printed_error:
        print("<h2 style='color:red'>Hm, the tests failed early.  It is possible you have a memory exception error (segmentation fault).</h2>")

p = multiprocessing.Process(target = runtests, args=(TEMPDIR,))
p.start()
p.join()

print("</body></html>")
