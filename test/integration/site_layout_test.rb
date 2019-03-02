require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links' do
    get root_path
    follow_redirect!
    assert_template 'sessions/new'
    assert_select 'a[href=?]', '/', text: 'Home'
    assert_select 'a[href=?]', '/login', text: I18n.t('log_in')
  end
end
