module AssignmentsHelper
  def self.testing_tool_path
    File.join(TEST_TOOL_CONFIG["home_path"],
    TEST_TOOL_CONFIG["testing_tool_relative_path"])
  end

  def self.assignments_path
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

  def self.ruby_executable
    TEST_TOOL_CONFIG["ruby_executable"]
  end

  def self.getEditorText(user, assignment)
    if (user.hasSolutionFileForAssignment?(assignment))
      return user.getSolutionFileContentsForAssignment(assignment)
    elsif assignment.hasSpecFile?
      return assignment.getSpecFileContents()
    else
      return ""
    end
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "alert-success"
    when "error"
      "alert-danger"
    when "alert"
      "alert-warning"
    when "notice"
      "alert-info"
    else
      flash_type.to_s
    end
  end

end
