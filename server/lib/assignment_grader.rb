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

    source_file.unlink
  end

  def getProgressBarHTML
    xml_result = @test_report["gtest_xml_report"]
    compile_errors = @test_report["compile_errors"]
    runtime_errors = @test_report["runtime_errors"]
    did_timeout = @test_report["timeout_error"]

    xml_parse = Nokogiri::Slop(xml_result)
    tests_array = xml_parse.xpath("//testcase")

    progress_bar_html = ""
    width = 100.0
    bar_message = ""
    failure_message = ""
    popover_title = ""
    progress_bar_type = ""
    inputs = ""
    message = ""

    #No errors with code
    if xml_result.length > 0
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
        progress_bar_html += "
        <span data-toggle=\"modal\" data-target=\"#error_modal\"><div class=\"progress-bar #{progress_bar_type}\" data-toggle=\"popover\" title=\"#{popover_title}\" data-html=\"true\" data-content=\"#{failure_message}\" data-placement=\"bottom\" data-trigger=\"hover\" style=\"width: #{width}%; \"></div></span>"
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
        bar_message = "Timout. Infinite loop?"
        progress_bar_type = "progress-bar-info"
      end
    end

    #Failsafe if no xml report or errors are generated
    if progress_bar_type.length == 0
      failure_message="NO XML REPORT OR ERRORS GENERATED"
      bar_message = "CRITICAL ERROR"
      popover_title = "CRITICAL ERROR"
      progress_bar_type = "progress-bar-variant(#e100ff)"
    end

    progress_bar_html += "
    <span data-toggle=\"modal\" data-target=\"#error_modal\"><div class=\"progress-bar #{progress_bar_type}\" data-toggle=\"popover\" title=\"#{popover_title}\" data-html=\"true\" data-content=\"#{failure_message}\" data-placement=\"bottom\" data-trigger=\"hover\" style=\"width: #{width}%; \">#{bar_message}</div></span>"
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

end
