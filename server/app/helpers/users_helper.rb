module UsersHelper
  def self.getCurrentUser
    User.first
  end
end
