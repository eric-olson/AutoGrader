require 'tmpdir'
require 'fileutils'
require 'json'
require 'timeout'

class TestEnvironment
  attr_reader :temp_dir, :test_file_path, :source_file_path, :common_dir, :compile_errors, :runtime_errors, :timeout

  def initialize(temp_dir, test_file_path, source_file_path, common_dir)
    @temp_dir = temp_dir
    @test_file_path = test_file_path
    @source_file_path = source_file_path
    @common_dir = common_dir
    @runtime_errors = ""
    @compile_errors = ""
    @timeout_error = false

    prepareTestEnvironment()
    enterTempDir()
    buildTests()
  end

  def getTestReportJSON
    {
      :gtest_xml_report => getTestDetailXML,
      :compile_errors => @compile_errors,
      :runtime_errors => @runtime_errors,
      :timeout_error => @timeout_error
    }.to_json
  end

  def run
    pid = Process.fork {
      #enterChrootJail()
      executeTests()
    }
    begin
      status = Timeout::timeout(10) {
        Process.wait(pid)
      }
    rescue Timeout::Error
      Process.kill('KILL', pid)
      @timeout_error = true
    end

    begin
      backtrace_file = File.open("backtrace.txt")
      @runtime_errors = backtrace_file.read
    rescue Errno::ENOENT
    end
  end

  private
  def prepareTestEnvironment
    FileUtils.cp(source_file_path, File.join(temp_dir, 'solution.cpp'))
    FileUtils.cp(test_file_path, File.join(temp_dir, 'tests.cpp'))
    FileUtils.cp(File.join(common_dir, 'main.o'), temp_dir)
    FileUtils.cp(File.join(common_dir, 'sighandler.o'), temp_dir)
    FileUtils.cp(File.join(common_dir, 'assoc.h'), temp_dir)
    FileUtils.cp(File.join(common_dir, 'newtracker.cpp'), temp_dir)
    FileUtils.cp_r(File.join(common_dir, 'tmpenv', '.'), temp_dir)
  end

  def buildTests
    # Maybe replace with a makefile to make life easier??
    @compile_errors = `g++ -g -rdynamic -o tests -I. -I/usr/local/include/StanfordCPPLib -std=c++11 -pthread tests.cpp main.o sighandler.o /usr/local/lib/gtest/libgtest.a /usr/local/lib/StanfordCPPLib/libStanfordCPPLib.a 2>&1`
  end

  def enterChrootJail
    Dir.chroot(temp_dir)
  end

  def enterTempDir
    FileUtils.chdir(temp_dir)
  end

  def executeTests
    `./tests --gtest_output=xml 2>&1`
  end

  def getTestDetailXML
    begin
      file = File.open("test_detail.xml")
      return file.read
    rescue Errno::ENOENT
      return ""
    end
  end

end

def showHelp
  puts "Intended use:"
  puts "    ruby test_tool.rb <test_file_path> <source_file_path> <common_file_path>"
end

if (ARGV.length != 3)
  showHelp()
  exit()
end

test_file_path = ARGV[0]
source_file_path = ARGV[1]
common_file_path = ARGV[2]

temp_dir_prefix = "user"
temp_dir = Dir.mktmpdir(temp_dir_prefix)

test_environment = TestEnvironment.new(temp_dir, test_file_path, source_file_path, common_file_path)
test_environment.run()
puts test_environment.getTestReportJSON()

FileUtils.remove_entry(temp_dir)
