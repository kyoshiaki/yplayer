require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: '', password: 'foo', password_confirmation: 'bar', admin: true } }
    assert_template 'users/edit'
    assert_select 'div#error_explanation li', count: 3
  end

  test 'successful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Foo Bar'
    patch user_path(@user), params: { user: { name: name, password: '', password_confirmation: '', admin: true } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
  end

  test 'successful edit with friendly forwarding' do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to directories_show_path
    name = 'Foo Bar'
    patch user_path(@user), params: { user: { name: name, password: '', password_confirmation: '', admin: true } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
  end
end
