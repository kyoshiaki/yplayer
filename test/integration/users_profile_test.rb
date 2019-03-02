require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test 'profile display' do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title('yplayer')
    assert_select 'p', text: @user.name
    assert_match @user.sounds.count.to_s, response.body
    assert_select 'li'
    sounds = @user.sounds.order(updated_at: :desc)
    sounds.page(1).each do |sound|
      assert_match radio_dirname(sound.path), response.body
      assert_match sound.name, response.body
    end
  end
end
