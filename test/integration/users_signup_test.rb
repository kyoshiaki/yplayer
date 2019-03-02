require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: '', password: 'password', password_confirmation: 'password', admin: true } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'valid signup information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'Example User', password: 'password', password_confirmation: 'password', admin: true } }
    end
    follow_redirect!
    assert_template 'directories/show'
    assert_not flash.empty?
  end
end
