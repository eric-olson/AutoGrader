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
      user.password = Devise.friendly_token[0,20]
    end
  end

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
