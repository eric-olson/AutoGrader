module AssignmentsHelper
  def self.testing_tool_path
    File.join(TEST_TOOL_CONFIG["home_path"],
              TEST_TOOL_CONFIG["testing_tool_relative_path"])
  end

  def self.assignments_path
    puts TEST_TOOL_CONFIG["assignments_relative_path"]
    File.join(TEST_TOOL_CONFIG["home_path"],
              TEST_TOOL_CONFIG["assignments_relative_path"])
  end

  def self.users_path
    File.join(TEST_TOOL_CONFIG["home_path"],
              TEST_TOOL_CONFIG["users_relative_path"])
  end

  def self.common_path
    File.join(TEST_TOOL_CONFIG["home_path"],
              TEST_TOOL_CONFIG["common_relative_path"])
  end

  def self.testing_tool_script
    File.join(TEST_TOOL_CONFIG["home_path"],
              TEST_TOOL_CONFIG["testing_tool_script"])
  end

end
