class User < ActiveRecord::Base
  has_many :grades

  def getHomeDirectory
    File.join(AssignmentsHelper.users_path, multipass_id)
  end
end
