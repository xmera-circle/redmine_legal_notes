# frozen_string_literal: true

# This file is part of the Plugin Redmine Legal Notes.
#
# Copyright (C) 2020-2021 Liane Hampe <liaham@xmera.de>, xmera.
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
require File.expand_path("#{File.dirname(__FILE__)}/../authenticate_user")
require File.expand_path("#{File.dirname(__FILE__)}/../load_fixtures")

##
# Make sure legal notes are rendered properly.
#
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

  test 'should render legal notes if login is required' do
    with_settings login_required: '1' do
      show_legal_notes('legal-notice')
    end
  end

  test 'should render legal notes if login is not required' do
    with_settings login_required: '0' do
      show_legal_notes('legal-notice')
    end
  end

  test 'should render legal notes only if it exists' do
    with_settings login_required: '0' do
      get '/'
      assert_select '.legal-notes-link a'
    end
  end

  private

  def show_legal_notes(name)
    get "/#{name}"
    assert_response :success
    assert_select '.wiki.wiki-page', text: name.gsub('-', ' ').titleize
  end
end
