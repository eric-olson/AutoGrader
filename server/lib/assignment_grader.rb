class TestResults
  def initialize(test_report)
    @test_report = test_report
  end

  def hasXMLReport?
    @test_report["gtest_xml_report"].length > 0
  end

  def hasCompileErrors?
    @test_report["compile_errors"].length > 0
  end

  def hasRuntimeErrors?
    @test_report["runtime_errors"].length > 0
  end

  def testTimeout?
    @test_report["timeout_error"]
  end

  def getCompilerErrorMessage
    @test_report["compile_errors"]
  end

  def getRuntimeErrorMessage
    @test_report["runtime_errors"]
  end
end

class AssignmentGrader
  def initialize(assignment, source_code)
    @assignment = assignment
    @source_code = source_code
    @test_report = ""
  end

  def runTests
    # Create tempfile and write the editor text to it
    source_file_prefix = "solution"
    source_file = Tempfile.new(source_file_prefix)
    source_file.write(@source_code)
    source_file.close

    source_file_path = source_file.path
    test_file_path = @assignment.getTestFilePath()

    command_to_run = "#{AssignmentsHelper.ruby_executable} #{AssignmentsHelper.testing_tool_script} #{test_file_path} #{source_file_path} #{AssignmentsHelper.common_path}"

    json_test_report = `#{command_to_run}`

    @test_report = JSON.parse(json_test_report)
    @test_results = TestResults.new(@test_report)
    source_file.unlink
  end

  def getProgressBarHTML
    xml_result = @test_report["gtest_xml_report"]

    progress_bar_html = ""
    width = 100.0
    bar_message = ""
    failure_message = ""
    popover_title = ""
    progress_bar_type = ""
    progress_bar_id = ""
    inputs = ""
    message = ""

    #No errors with code
    if @test_results.hasXMLReport?
      xml_parse = Nokogiri::Slop(xml_result)
      tests_array = xml_parse.xpath("//testcase")
      width /= tests_array.size
      tests_array.each { |test|
        failed = test.respond_to?(:failure)
        if (test[:value_param].index(",") != nil)
          inputs = "Inputs: " + test[:value_param]
        else
          inputs = "Input: " + test[:value_param]
        end
        cutoff = inputs.rindex(':')
        expected_value = inputs[(cutoff+1)..-1]
        failure_message = inputs[0..(cutoff-1)] + " <br/> "
        failure_message.gsub!("\"", "&quot")

        if failed
          message = test.failure[:message]
          message.gsub!("\n", "<br/>")
          message = message[message.index("Actual:")..(message.index("Expected: ")+9)]
          message += expected_value

          failure_message += message
          popover_title = "Failed Test"
          progress_bar_type = "progress-bar-danger"
        else
          failure_message += "Output: " + expected_value
          popover_title = "Passed Test"
          progress_bar_type = "progress-bar-success"
        end

        failure_message = failure_message.html_safe
        progress_bar_html += getSingleProgressBarHTML(progress_bar_type,
                                                      progress_bar_id,
                                                      popover_title,
                                                      failure_message,
                                                      width,
                                                      "")
      }

    else
      #Compilation error
      if @test_results.hasCompileErrors?
        failure_message = @test_results.getCompilerErrorMessage
        popover_title = "Compilation Error"
        bar_message = "Compilation Error"
        progress_bar_type = "progress-bar-danger"
        progress_bar_id = "compile-error"
      end

      #Runtime error
      if @test_results.hasRuntimeErrors?
        failure_message = @test_results.getRuntimeErrorMessage
        popover_title = "Runtime Error"
        bar_message = "Runtime Error"
        progress_bar_type = "progress-bar-warning"
        progress_bar_id = "runtime-error"
      end

      #Timeout error
      if @test_results.testTimeout?
        failure_message = ""
        popover_title = ""
        bar_message = "Timout. Infinite loop?"
        progress_bar_type = "progress-bar-info"
        progress_bar_id = "timeout-error"
      end
    end

    #Failsafe if no xml report or errors are generated
    if progress_bar_type.length == 0
      failure_message="NO XML REPORT OR ERRORS GENERATED"
      bar_message = "CRITICAL ERROR"
      popover_title = "CRITICAL ERROR"
      progress_bar_type = "progress-bar-variant(#e100ff)"
    end

    failure_message = failure_message.html_safe
    failure_message.gsub!("\n", "<br/>")

    progress_bar_html += getSingleProgressBarHTML(progress_bar_type,
                                                  progress_bar_id,
                                                  popover_title,
                                                  failure_message,
                                                  width,
                                                  bar_message)
    return progress_bar_html
  end

  def getGrade
    xml_result = @test_report["gtest_xml_report"]
    xml_parse = Nokogiri::Slop(xml_result)
    tests_array = xml_parse.xpath("//testcase")

    passed_tests = 0
    total_tests = 0

    tests_array.each { |test|
      failed = test.respond_to?(:failure)
      if !failed
        passed_tests += 1
      end

      total_tests += 1
    }

    grade = (passed_tests.to_f / total_tests.to_f) * 10
    puts "Grade: " + grade.to_s
    return grade
  end

  private
  def getSingleProgressBarHTML(type, id, title, message, width, bar_message)
    message_truncated = "<samp>" + message[0..100] + "...</samp>" + "<p>Click bar for more detail</p>"
    message = "<samp>" + message + "</samp>"

    "<div class=\"progress-bar #{type} progress-bar-clickable\" id=\"#{id}\" data-toggle=\"popover\" title=\"#{title}\" data-html=\"true\" data-content=\"#{message_truncated}\" data-placement=\"bottom\" data-trigger=\"hover\" style=\"width: #{width}%; \">#{bar_message}<div class=\"failure-message-full\">#{message}</div></div>"
  end

end
