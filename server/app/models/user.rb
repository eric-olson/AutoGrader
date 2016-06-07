class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
  has_many :grades

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.multipass_id = auth.info.first_name
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end
  end

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

  def writeToSolutionFileForAssignment(assignment, to_write_solution)
    # Get the assignment folder path and create it if it doesn't exist
    assignment_folder_path = getDirectoryForAssignment(assignment)
    FileUtils.mkdir_p(assignment_folder_path)

    # Get the assignment file name
    assignment_file_path = getSolutionFilepathForAssignment(assignment)
    # Write the assignment file using the editor source
    assignment_file = File.open(assignment_file_path, "w")
    assignment_file.write(to_write_solution)
    assignment_file.close
  end

  def hasSolutionFileForAssignment?(assignment)
    FileTest.exists?(getSolutionFilepathForAssignment(assignment))
  end

end
