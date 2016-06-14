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

common_file_path = ARGV[2]

sample_xml_file = File.open(File.join(common_file_path, 'sample_output.xml'))
xml_data = sample_xml_file.read

# Just to make it easier to test the progress bar
error_type = "compiler"

if error_type == "none"
  json_result = {
    :gtest_xml_report => xml_data,
    :compile_errors => "",
    :runtime_errors => "",
    :timeout_error => false
  }.to_json
elsif error_type == "compiler"
  json_result = {
    :gtest_xml_report => "",
    :compile_errors => "Some GCC output",
    :runtime_errors => "",
    :timeout_error => false
  }.to_json
elsif error_type == "runtime"
  json_result = {
    :gtest_xml_report => "",
    :compile_errors => "",
    :runtime_errors => "Some backtrace from the runtime error",
    :timeout_error => false
  }.to_json
elsif error_type == "timeout"
  json_result = {
    :gtest_xml_report => "",
    :compile_errors => "",
    :runtime_errors => "",
    :timeout_error => true
  }.to_json
end

puts json_result
