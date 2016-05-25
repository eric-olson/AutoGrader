module AssignmentsHelper
  @home_path = "/home/crice/AutoGrader"
  @testing_tool_relative_path = "testing_tool"
  @problems_relative_path = "problems"
  @common_relative_path = "common"
  @users_relative_path = "users"

  def self.testing_tool_path
      File.join(@home_path, @testing_tool_relative_path)
  end

  def self.problems_path
      File.join(@home_path, @problems_relative_path)
  end

  def self.users_path
      File.join(@home_path, @users_relative_path)
  end

  def self.common_path
      File.join(@home_path, @common_relative_path)
  end

end
