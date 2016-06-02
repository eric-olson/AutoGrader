# require 'file'
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

  def self.getUserAssignmentFolderPath(user, assignment)
    File.join(user.getHomeDirectory, assignment.getFolderName())
  end

  def self.getAssignmentFilename()
    "solution.cpp"
  end

  def self.getUserAssignmentFilePath(user, assignment)
    File.join(getUserAssignmentFolderPath(user, assignment), getAssignmentFilename)
  end

  def self.getEditorText(user, assignment)
    editor_text_file_path = ""

    assignment_file_path = user.getFilepathForAssignment(assignment)
    spec_file_path = assignment.getSpecFilePath()
    editor_text_file_path = ""

    if (FileTest.exists?(assignment_file_path))
      editor_text_file_path = assignment_file_path
    else
      editor_text_file_path = spec_file_path
    end

    editor_file_contents = ""
    begin
      editor_text_file = File.open(editor_text_file_path)
      editor_file_contents = editor_text_file.read
    rescue Errno::ENOENT
      # We should probably fill with a default spec file here.
      editor_file_contents = ""
    end

    return editor_file_contents
  end

  def self.generateProgressBarHTMLFromTestsArray(tests_array)
    progress_bar_html = ""
    width = 100.0 / tests_array.size

    tests_array.each { |test|
      failed = test.respond_to?(:failure)
      progress_bar_type = ""
      popover_title = ""
      failure_message = ""
      if failed
        failure_message = test.failure[:message]
        failure_message.gsub!("\n", "<br/>")
        popover_title = "Failed Test"
        progress_bar_type = "progress-bar-danger"
      else
        popover_title = "Passed Test"
        progress_bar_type = "progress-bar-success"
      end

      progress_bar_html += "
        <div class=\"progress-bar #{progress_bar_type}\" data-toggle=\"popover\" title=\"#{popover_title}\" data-html=\"true\" data-content=\"#{failure_message}\" data-placement=\"bottom\" data-trigger=\"hover\" style=\"width: #{width}%; \"></div>"
    }
    return progress_bar_html
  end

end
