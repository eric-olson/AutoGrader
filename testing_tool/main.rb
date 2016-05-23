require 'tmpdir'
require 'fileutils'

# assignment_path = ARGV[0]
# source_file_path = ARGV[1]



def prepareTestEnvironment(dir)
    # shutil.copy(CWD + '/tests.cpp', TEMPDIR);
    # shutil.copy(COMMONDIR + '/main.o', TEMPDIR);
    # shutil.copy(COMMONDIR + '/sighandler.o', TEMPDIR);
    # shutil.copy(COMMONDIR + '/assoc.h', TEMPDIR);
    # shutil.copy(COMMONDIR + '/newtracker.cpp', TEMPDIR);

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

def runTests(dir)

end

Dir.mktmpdir('user') { |dir|
    prepareTestEnvironment(dir)
    FileUtils.chdir(dir)
    puts `pwd`
    puts `ls -lR`
    runTests(dir)
}
