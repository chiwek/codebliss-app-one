require 'test_helper'

class WebhooksControllerTest < ActionController::TestCase
  test "should get uninstall" do
    get :uninstall
    assert_response :success
  end

end
