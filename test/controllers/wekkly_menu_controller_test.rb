require 'test_helper'

class WekklyMenuControllerTest < ActionController::TestCase
  test "should get manage" do
    get :manage
    assert_response :success
  end

end
