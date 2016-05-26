class Assignment < ActiveRecord::Base
  belongs_to :lab
  has_many :grades

  def getPath
    return name
  end
end
