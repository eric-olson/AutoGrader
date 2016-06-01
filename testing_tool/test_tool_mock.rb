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

json_result = {
  :gtest_xml_report => xml_data,
  :compile_errors => "",
  :runtime_errors => ""
}.to_json

puts json_result
#puts '<WARNING> This has been generated from ' + $PROGRAM_NAME + ', it is not a real test report! </WARNING>'
