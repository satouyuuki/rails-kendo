require 'test_helper'

class OpponentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get opponents_index_url
    assert_response :success
  end

end
