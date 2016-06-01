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

  def self.generateProgressBarHTMLFromTestReport(test_report)

    xml_result = test_report["gtest_xml_report"]
    compile_errors = test_report["compile_errors"]
    runtime_errors = test_report["runtime_errors"]
    did_timeout = test_report["timeout_error"]

    xml_parse = Nokogiri::Slop(xml_result)
    tests_array = xml_parse.xpath("//testcase")

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
