require 'test_helper'

class SoundsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @sound = sounds(:orange)
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Sound.count' do
      delete sound_path(@sound)
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy for wrong sound' do
    log_in_as(users(:michael), password: 'password', remember_me: '0')

    sound = sounds(:ants)
    assert_no_difference 'Sound.count' do
      delete sound_path(sound)
    end
    assert_redirected_to root_url
  end
end
