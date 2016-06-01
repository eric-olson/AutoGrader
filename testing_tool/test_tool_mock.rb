# Returns a canned xml test report from google test
# Intended for use on non-linux development environments where the actual test tool does not work.

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
puts {
  :gtest_xml_report => sample_xml_file.read,
  :compile_errors => "",
  :runtime_errors => ""
}.to_json
#puts '<WARNING> This has been generated from ' + $PROGRAM_NAME + ', it is not a real test report! </WARNING>'
