require 'test_helper'

class SoundTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @sound = @user.sounds.build(path: 'radio/sample.mp3', name: 'sample.mp3', listened: false, playhead: 100)
  end

  test 'should be valid' do
    assert @sound.valid?
  end

  test 'user id should be present' do
    @sound.user_id = nil
    assert_not @sound.valid?
  end

  test 'path and name should be present' do
    @sound.path = '   '
    assert_not @sound.valid?
    @sound.name = '   '
    assert_not @sound.valid?
  end

  test 'path should be at most 4096 characters' do
    @sound.path = 'a' * 4097
    assert_not @sound.valid?
  end

  test 'name should be at most 255 characters' do
    @sound.name = 'a' * 256
    assert_not @sound.valid?
  end

  #  test "order should be most recent first" do
  #    assert_equal sounds(:most_recent), Sound.first
  #  end
end
