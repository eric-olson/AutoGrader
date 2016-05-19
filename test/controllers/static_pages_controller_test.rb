require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get acetest" do
    get :acetest
    assert_response :success
  end

end
