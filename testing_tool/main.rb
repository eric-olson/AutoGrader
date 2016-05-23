require 'tmpdir'
require 'fileutils'

assignment_path = ARGV[0]
source_file_path = ARGV[1]

common_dir = 'common'

def prepareTestEnvironment(dir)
    # shutil.copy(CWD + '/tests.cpp', TEMPDIR);
    # shutil.copy(COMMONDIR + '/main.o', TEMPDIR);
    # shutil.copy(COMMONDIR + '/sighandler.o', TEMPDIR);
    # shutil.copy(COMMONDIR + '/assoc.h', TEMPDIR);
    # shutil.copy(COMMONDIR + '/newtracker.cpp', TEMPDIR);

    FileUtils.cp(assignment_path, File.join(dir, 'solution.cpp'))
    FileUtils.cp(File.join(source_file_path, 'tests.cpp'), dir)
    FileUtils.cp(File.join(common_dir, 'main.o'), dir)
    FileUtils.cp(File.join(common_dir, 'sighandler.o'), dir)
    FileUtils.cp(File.join(common_dir, 'assoc.h'))
    FileUtils.cp(File.join(common_dir, 'newtracker.cpp'))
end

def runTests(dir)

end

Dir.mktmpdir('user') { |dir|
    prepareTestEnvironment(dir)
    FileUtils.chdir(dir)
    runTests(dir)
}
