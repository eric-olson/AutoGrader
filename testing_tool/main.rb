require 'tmpdir'
require 'fileutils'

# assignment_path = ARGV[0]
# source_file_path = ARGV[1]



def prepareTestEnvironment(dir)
    common_dir = 'common'
    assignment_path = 'problems/anonymous/'
    source_file_path = 'anonymous_solution.cpp'

    FileUtils.cp(source_file_path, File.join(dir, 'solution.cpp'))
    FileUtils.cp(File.join(assignment_path, 'tests.cpp'), dir)
    FileUtils.cp(File.join(common_dir, 'main.o'), dir)
    FileUtils.cp(File.join(common_dir, 'sighandler.o'), dir)
    FileUtils.cp(File.join(common_dir, 'assoc.h'), dir)
    FileUtils.cp(File.join(common_dir, 'newtracker.cpp'), dir)
    FileUtils.cp_r(File.join(common_dir, 'tmpenv'), dir)
end

def buildTests(dir)
    puts `g++ -g -rdynamic -o tests -I. -I/usr/local/include/StanfordCPPLib -std=c++11 -pthread tests.cpp main.o sighandler.o /usr/local/lib/gtest/libgtest.a /usr/local/lib/StanfordCPPLib/libStanfordCPPLib.a`
end

def runTests(dir)

end

Dir.mktmpdir('user') { |dir|
    prepareTestEnvironment(dir)
    FileUtils.chdir(dir)
    buildTests(dir)
    runTests(dir)
}
