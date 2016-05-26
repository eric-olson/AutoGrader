class Assignment < ActiveRecord::Base
  belongs_to :lab
  has_many :grades

  def getPath
    File.join(AssignmentsHelper.assignments_path, name)
  end

  def getTestFilePath
    File.join(getPath, 'tests.cpp')
  end

  def getSpecFilePath
    File.join(getPath, 'spec.cpp')
  end
end
