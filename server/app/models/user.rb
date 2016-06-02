class User < ActiveRecord::Base
  has_many :grades

  def getHomeDirectory
    File.join(AssignmentsHelper.users_path, multipass_id)
  end

  def getDirectoryForAssignment(assignment)
    File.join(getHomeDirectory, assignment.getDirectoryName())
  end

  def getSolutionFilepathForAssignment(assignment)
    File.join(getDirectoryForAssignment(assignment), assignment.getFileName())
  end

  def getSolutionFileContentsForAssignment(assignment)
    assignment_file_path = getSolutionFilepathForAssignment(assignment)

    assignment_file_contents = ""
    begin
      assignment_file = File.open(assignment_file_path)
      assignment_file_contents = assignment_file.read
    rescue Errno::ENOENT
      assignment_file_contents = ""
    end

    return assignment_file_contents
  end

  def hasSolutionFileForAssignment?(assignment)
    FileTest.exists?(getSolutionFilepathForAssignment(assignment))
  end
end
