class User < ActiveRecord::Base
  has_many :grades

  def getHomeDirectory
    File.join(AssignmentsHelper.users_path, multipass_id)
  end

  def getDirectoryForAssignment(assignment)
    File.join(getHomeDirectory, assignment.getFolderName())
  end

  def getFilepathForAssignment(assignment)
    File.join(getDirectoryForAssignment(assignment), assignment.getFileName())
  end
end
