module AssignmentsHelper
  @home_path = "/home/crice/AutoGrader"
  @testing_tool_relative_path = "testing_tool"
  @problems_relative_path = "problems"
  @common_relative_path = "common"
  @users_relative_path = "users"
  @test_tool_executable_name = "test_tool.rb"

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

  def self.test_tool_executable
      File.join(testing_tool_path, @test_tool_executable_name)
  end

end
