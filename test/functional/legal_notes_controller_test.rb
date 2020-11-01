# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../test_helper")

class LegalNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Setting.plugin_redmine_legal_notes = { legal_notice: 'Legal Notice',
      data_privacy_policy: 'Data Privacy Policy' }
  end

  teardown do
    Setting.delete_all
    Setting.clear_cache
  end

  test 'should get index' do
    LegalNote.names.each do |name|
      get legal_notes_url(name: name)
      assert_response :success
    end
  end

  test 'should display html title' do
    get legal_notes_url(name: :legal_notice)
    assert_select 'title', html_title('Legal Notice')
  end

  test 'should render text' do
    get legal_notes_url(name: :legal_notice)
    assert_select 'p', 'Legal Notice'
    get legal_notes_url(name: :data_privacy_policy)
    assert_select 'p', 'Data Privacy Policy'
  end

  private

  def html_title(page_name)
    "#{page_name} - #{Setting.app_title}"
  end
end