# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../test_helper")
require File.expand_path("#{File.dirname(__FILE__)}/../authenticate_user")
require File.expand_path("#{File.dirname(__FILE__)}/../load_fixtures")

class LegalNotesViewTest < ActionDispatch::IntegrationTest
  include RedmineLegalNotes::AuthenticateUser
  include RedmineLegalNotes::LoadFixtures

  fixtures :users, :email_addresses, :roles

  setup do
    Setting.plugin_redmine_legal_notes = { legal_notice: 'Legal Notice',
      data_privacy_policy: '' }
  end

  teardown do
    Setting.delete_all
    Setting.clear_cache
  end

  test "should render legal notes if login is required" do
    with_settings :login_required => '1' do
      get_legal_notes('legal-notice')
    end
  end

  test "should render legal notes if login is not required" do
    with_settings :login_required => '0' do
      get_legal_notes('legal-notice')
    end
  end

  private

  def get_legal_notes(name)
    get "/#{name}"
    assert_response :success
    assert_select '.wiki.wiki-page', text: name.gsub('-', ' ').titleize
  end
end