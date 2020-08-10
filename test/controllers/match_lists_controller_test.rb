require 'test_helper'

class MatchListsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get match_lists_show_url
    assert_response :success
  end

end
