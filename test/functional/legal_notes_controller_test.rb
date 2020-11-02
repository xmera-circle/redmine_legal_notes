# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../test_helper")

class LegalNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Setting.plugin_redmine_legal_notes = { legal_notice: 'Legal Notice',
      data_privacy_policy: '' }
  end

  teardown do
    Setting.delete_all
    Setting.clear_cache
  end

  test 'should get index' do
    get legal_notes_url(name: 'legal-notice')
    assert_response :success
  end

  test 'should display html title' do
    get legal_notes_url(name: 'legal-notice')
    assert_select 'title', html_title('Legal Notice')
  end

  test 'should render text' do
    get legal_notes_url(name: 'legal-notice')
    assert_select 'p', 'Legal Notice'
    get legal_notes_url(name: 'data-privacy-policy')
    assert_redirected_to home_path
  end

  private

  def html_title(page_name)
    "#{page_name} - #{Setting.app_title}"
  end
end