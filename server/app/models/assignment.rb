class Assignment < ActiveRecord::Base
  belongs_to :lab
  has_many :grades, :dependent => :destroy

  def getPath
    File.join(AssignmentsHelper.assignments_path, getDirectoryName())
  end

  def getTestFilePath
    File.join(getPath, 'tests.cpp')
  end

  def getSpecFilePath
    File.join(getPath, 'spec.cpp')
  end

  def getSpecFileContents
    begin
      spec_file = File.open(getSpecFilePath())
      spec_file_contents = spec_file.read
    rescue Errno::ENOENT
      # We should probably fill with a default spec file here.
      spec_file_contents = ""
    end

    return spec_file_contents
  end

  def hasSpecFile?
    FileTest.exists?(getSpecFilePath())
  end

  def getDirectoryName
    sanitizeFilename(name)
  end

  def getFileName
    "solution.cpp"
  end

  def sanitizeFilename(filename)
    # Split the name when finding a period which is preceded by some
    # character, and is followed by some character other than a period,
    # if there is no following period that is followed by something
    # other than a period (yeah, confusing, I know)
    fn = filename.split /(?<=.)\.(?=[^.])(?!.*\.[^.])/m

    # We now have one or two parts (depending on whether we could find
    # a suitable period). For each of these parts, replace any unwanted
    # sequence of characters with an underscore
    fn.map! { |s| s.gsub /[^a-z0-9\-]+/i, '_' }

    # Join the parts with a period and return the result
    fn = fn.join '.'

    # Finally, return the lowercased version
    return fn.downcase
  end
end
