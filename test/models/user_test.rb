require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'foobar', password: 'foobar', password_confirmation: 'foobar', admin: true, created_at: DateTime.now.in_time_zone, updated_at: DateTime.now.in_time_zone)
  end

  test 'should be vaild' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '      '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 256
    assert_not @user.valid?
  end

  test 'name should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?('')
  end

  test 'associated sounds should be destroyed' do
    @user.save
    @user.sounds.create!(path: 'radio/sample.mp3', name: 'sample.mp3', listened: false, playhead: 100)

    assert_difference 'Sound.count', -1 do
      @user.destroy
    end
  end
end
