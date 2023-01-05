# frozen_string_literal: true

# This file is part of the Plugin Redmine Legal Notes.
#
# Copyright (C) 2020-2023 Liane Hampe <liaham@xmera.de>, xmera.
#
# This plugin program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

require File.expand_path("#{File.dirname(__FILE__)}/../test_helper")

##
# Make sure legal notes are rendered properly.
#
class LegalNotesViewTest < ActionDispatch::IntegrationTest
  include RedmineLegalNotes::AuthenticateUser
  include RedmineLegalNotes::LoadFixtures

  fixtures :users, :email_addresses, :roles

  setup do
    Setting.plugin_redmine_legal_notes = { legal_notice: '',
                                           data_privacy_policy: 'Data Privacy Policy',
                                           enable_privacy_consent: 'true',
                                           privacy_consent_text: 'I agree' }
  end

  teardown do
    Setting.delete_all
    Setting.clear_cache
  end

  test 'should render legal notes if login is required' do
    with_settings login_required: '1' do
      show_legal_notes('data-privacy-policy')
    end
  end

  test 'should render legal notes if login is not required' do
    with_settings login_required: '0' do
      show_legal_notes('data-privacy-policy')
    end
  end

  test 'should render legal notes only if it exists' do
    with_settings login_required: '0' do
      get '/'
      assert_select '.legal-notes-link a'
    end
  end

  test 'should render privacy consent form on register page if enabled' do
    with_settings self_registration: 2 do
      get register_path
      assert_response :success
      assert_select '#user_privacy_consent'
    end
  end

  test 'should not render privacy consent form on register page if not enabled' do
    Setting.clear_cache
    Setting.plugin_redmine_legal_notes = { legal_notice: '',
                                           data_privacy_policy: 'Data Privacy Policy',
                                           privacy_consent_text: 'I agree' }
    get register_path
    assert :success
    assert_select '#user_privacy_consent', 0
  end

  test 'should not render privacy consent form on register page if no policy exists' do
    Setting.clear_cache
    Setting.plugin_redmine_legal_notes = { legal_notice: '',
                                           data_privacy_policy: '',
                                           enable_privacy_consent: 'true',
                                           privacy_consent_text: 'I agree' }
    get register_path
    assert :success
    assert_select '#user_privacy_consent', 0
  end

  private

  def show_legal_notes(name)
    get legal_notes_path(name: name)
    assert_response :success
    assert_select '.wiki.wiki-page', text: name.tr('-', ' ').titleize
  end
end
