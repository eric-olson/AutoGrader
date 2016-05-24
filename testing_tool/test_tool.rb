require 'tmpdir'
require 'fileutils'

class TestEnvironment
    attr_reader :temp_dir, :assignment_path, :source_path, :common_dir

    def initialize(temp_dir, assignment_path, source_path)
        @temp_dir = temp_dir
        @assignment_path = assignment_path
        @source_path = source_path
        # Do this in config file instead
        @common_dir = 'common'

        prepareTestEnvironment()
        enterTempDir()
        buildTests()
    end

    def prepareTestEnvironment
        FileUtils.cp(source_path, File.join(temp_dir, 'solution.cpp'))
        FileUtils.cp(File.join(assignment_path, 'tests.cpp'), temp_dir)
        FileUtils.cp(File.join(common_dir, 'main.o'), temp_dir)
        FileUtils.cp(File.join(common_dir, 'sighandler.o'), temp_dir)
        FileUtils.cp(File.join(common_dir, 'assoc.h'), temp_dir)
        FileUtils.cp(File.join(common_dir, 'newtracker.cpp'), temp_dir)
        FileUtils.cp_r(File.join(common_dir, 'tmpenv'), temp_dir)
    end

    def enterTempDir
        FileUtils.chdir(temp_dir)
    end

    def buildTests
        # Maybe replace with a makefile to make life easier??
        `g++ -g -rdynamic -o tests -I. -I/usr/local/include/StanfordCPPLib -std=c++11 -pthread tests.cpp main.o sighandler.o /usr/local/lib/gtest/libgtest.a /usr/local/lib/StanfordCPPLib/libStanfordCPPLib.a`
    end

    def run
        # Need to chroot here
        `./tests --gtest_output=xml`
    end

    def getTestDetailXML
        `cat test_detail.xml`
    end

end

def showHelp
    puts "Intended use:"
    puts "    ruby test_tool.rb <assignment_path> <source_file_path>"
end

if (ARGV.length != 2)
    showHelp()
    exit()
end

assignment_path = ARGV[0]
source_file_path = ARGV[1]

Dir.mktmpdir('user') { |tempdir|
    test_environment = TestEnvironment.new(tempdir, assignment_path, source_file_path)
    test_environment.run()
    puts test_environment.getTestDetailXML()
}