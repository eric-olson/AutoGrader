require 'tempfile'
require 'fileutils'

class StaticPagesController < ApplicationController
    def acetest
    end

    def ProblemPage

    end

    def testCode
        editor_text = params[:editor_text]

        # Create tempfile and write the editor text to it
        source_file = Tempfile.new("solution")
        source_filepath = source_file.path
        source_file.write(editor_text)
        source_file.close

        testing_tool_path = "/home/crice/AutoGrader/testing_tool/"
        problem_path = "problems/anonymous"
        xml_result = ""
        old_dir = FileUtils.pwd
        FileUtils.chdir(testing_tool_path)
        xml_result = `ruby test_tool.rb #{problem_path} #{source_filepath}`
        FileUtils.chdir(old_dir)


        puts xml_result


        render nothing: true
    end
end
