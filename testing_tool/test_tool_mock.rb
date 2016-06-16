#!/usr/bin/ruby2.3

# Returns a canned xml test report from google test
# Intended for use on non-linux development environments where the actual test tool does not work.

require 'json'

def showHelp
    puts "Intended use:"
    puts "    ruby test_tool.rb <assignment_path> <source_file_path> <common_file_path>"
end

if (ARGV.length != 3)
    showHelp()
    exit()
end

source_file_path = ARGV[1]
common_file_path = ARGV[2]

sample_xml_file = File.open(File.join(common_file_path, 'sample_output.xml'))
xml_data = sample_xml_file.read


# Just to make it easier to test the progress bar
error_type = "none"
File.open(source_file_path) {|f|
  error_type = f.readline.chomp
}

if error_type == "compiler"
  json_result = {
    :gtest_xml_report => "",
    :compile_errors => "In file included from tests.cpp:4:0: solution.cpp: In function ‘int digit_sum(int)’: solution.cpp:4:12: error: invalid conversion from ‘int*’ to ‘int’ [-fpermissive] return a; ^ ",
    :runtime_errors => "",
    :timeout_error => false
  }.to_json
elsif error_type == "runtime"
  json_result = {
    :gtest_xml_report => "",
    :compile_errors => "",
    :runtime_errors => "./tests(_Z9digit_sumi+0x13)[0x447af9] ./tests(_ZN17CSCITest_sum_Test8TestBodyEv+0x51)[0x447b4f] ./tests(_ZN7testing8internal38HandleSehExceptionsInMethodIfSupportedINS_4TestEvEET0_PT_MS4_FS3_vEPKc+0x65)[0x473e1c] ./tests(_ZN7testing8internal35HandleExceptionsInMethodIfSupportedINS_4TestEvEET0_PT_MS4_FS3_vEPKc+0x5a)[0x46eab1] ./tests(_ZN7testing4Test3RunEv+0xd0)[0x453e6e] ./tests(_ZN7testing8TestInfo3RunEv+0x102)[0x454716] ./tests(_ZN7testing8TestCase3RunEv+0x101)[0x454e05] ./tests(_ZN7testing8internal12UnitTestImpl11RunAllTestsEv+0x2b8)[0x45bee2] ./tests(_ZN7testing8internal38HandleSehExceptionsInMethodIfSupportedINS0_12UnitTestImplEbEET0_PT_MS4_FS3_vEPKc+0x65)[0x4753f3] ./tests(_ZN7testing8internal35HandleExceptionsInMethodIfSupportedINS0_12UnitTestImplEbEET0_PT_MS4_FS3_vEPKc+0x5a)[0x46f95f] ./tests(_ZN7testing8UnitTest3RunEv+0xb6)[0x45a980] ./tests(_Z13RUN_ALL_TESTSv+0x11)[0x44d9b0] ./tests(main+0x2c)[0x44d94a] /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf0)[0x7f4465dfb830] ./tests(_start+0x29)[0x447a19] ",
    :timeout_error => false
  }.to_json
elsif error_type == "timeout"
  json_result = {
    :gtest_xml_report => "",
    :compile_errors => "",
    :runtime_errors => "",
    :timeout_error => true
  }.to_json
else
  json_result = {
    :gtest_xml_report => xml_data,
    :compile_errors => "",
    :runtime_errors => "",
    :timeout_error => false
  }.to_json
end

puts json_result
