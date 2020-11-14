# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/../test_helper")
require File.expand_path("#{File.dirname(__FILE__)}/../authenticate_user")
require File.expand_path("#{File.dirname(__FILE__)}/../load_fixtures")

class LegalNotesEditTest < ActionDispatch::IntegrationTest
  include RedmineLegalNotes::AuthenticateUser
  include RedmineLegalNotes::LoadFixtures

  fixtures :users, :email_addresses, :roles

  test "admin can edit legal notes" do
    log_user("admin", "admin")
    get "/settings/plugin/redmine_legal_notes"
    assert_response :success
  end 
end