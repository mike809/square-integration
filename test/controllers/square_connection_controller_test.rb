require 'test_helper'

class SquareConnectionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get square_connection_new_url
    assert_response :success
  end

  test "should get create" do
    get square_connection_create_url
    assert_response :success
  end

end
