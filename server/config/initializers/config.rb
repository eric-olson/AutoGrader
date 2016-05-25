begin
    TEST_TOOL_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/test_tool.yml")
rescue Errno::ENOENT
     puts "Please create a configuration file for the testing tool as 'config/test_tool.yml'."
     puts "Example configuration file found in 'config/test_tool_default.yml'."
     exit
end
