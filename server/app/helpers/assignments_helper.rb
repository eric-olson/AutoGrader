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

  def self.getEditorText(user, assignment)
    if (user.hasSolutionFileForAssignment?(assignment))
      return user.getSolutionFileContentsForAssignment(assignment)
    elsif assignment.hasSpecFile?
      return assignment.getSpecFileContents()
    else
      return ""
    end
  end

  def self.generateProgressBarHTMLFromTestReport(test_report)
    xml_result = test_report["gtest_xml_report"]
    compile_errors = test_report["compile_errors"]
    runtime_errors = test_report["runtime_errors"]
    did_timeout = test_report["timeout_error"]

    xml_parse = Nokogiri::Slop(xml_result)
    tests_array = xml_parse.xpath("//testcase")

    progress_bar_html = ""
    width = 100.0
    bar_message = ""
    failure_message = ""
    popover_title = ""
    progress_bar_type = ""

    #No errors with code
    if xml_result.length > 0
      width /= tests_array.size
      tests_array.each { |test|
        failed = test.respond_to?(:failure)
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

    else
      #Compilation error
      if compile_errors.length > 0
        failure_message = compile_errors
        popover_title = "Compilation Error"
        bar_message = "Compilation Error"
        progress_bar_type = "progress-bar-danger"
      end

      #Runtime error
      if runtime_errors.length > 0
        failure_message = runtime_errors
        popover_title = "Runtime Error"
        bar_message = "Runtime Error"
        progress_bar_type = "progress-bar-warning"
      end

      #Timeout error
      if did_timeout
        failure_message = ""
        popover_title = ""
        bar_message = "Compiler timout; infinite loop?"
        progress_bar_type = "progress-bar-info"
      end
    end

    #Failsafe if no xml report or errors are generated
    if progress_bar_type.length == 0
      failure_message="NO XML REPORT OR ERRORS GENERATED"
      bar_message = "CRITICAL ERROR"
      popover_title = "CRITIAL ERROR"
      progress_bar_type = "progress-bar-variant(#e100ff)"
    end

    progress_bar_html += "
    <div class=\"progress-bar #{progress_bar_type}\" data-toggle=\"popover\" title=\"#{popover_title}\" data-html=\"true\" data-content=\"#{failure_message}\" data-placement=\"bottom\" data-trigger=\"hover\" style=\"width: #{width}%; \">#{bar_message}</div>"
    return progress_bar_html
  end

end
