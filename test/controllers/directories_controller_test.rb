require 'test_helper'

class DirectoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:admin)
  end

  test 'should get show' do
    log_in_as(@admin)
    get directories_show_url
    assert_response :success
  end
end
