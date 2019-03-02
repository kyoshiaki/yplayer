require 'test_helper'

class SoundPlayersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin)
  end

  test 'should get show' do
    post login_path, params: { session: { name: @user.name, password: 'adminuser' } }
    assert helper_logged_in?
    get sound_players_show_url, params: { dirname: 'radio/foo', name: 'foo.mp3' }
    assert_response :success
  end
end
