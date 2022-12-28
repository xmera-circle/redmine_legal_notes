# frozen_string_literal: true

# This file is part of the Plugin Redmine Legal Notes.
#
# Copyright (C) 2020-2022 Liane Hampe <liaham@xmera.de>, xmera.
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
class LegalNotesFooterTest < ActionDispatch::IntegrationTest
  include RedmineLegalNotes::AuthenticateUser
  include RedmineLegalNotes::LoadFixtures

  fixtures :users, :email_addresses, :roles

  teardown do
    Setting.delete_all
    Setting.clear_cache
  end

  test 'should render legal notes page link' do
    Setting.plugin_redmine_legal_notes = { legal_notice: '',
                                           data_privacy_policy: 'Data Privacy Policy' }
    with_settings login_required: '0' do
      show_legal_notes_footer(1)
    end
  end

  test 'should render legal notice page link' do
    Setting.plugin_redmine_legal_notes = { legal_notice: 'Legal Notice',
                                           data_privacy_policy: '' }
    with_settings login_required: '0' do
      show_legal_notes_footer(1)
    end
  end

  test 'should render both links' do
    Setting.clear_cache
    Setting.plugin_redmine_legal_notes = { legal_notice: 'Legal Notice',
                                           data_privacy_policy: 'Data Privacy Policy' }
    with_settings login_required: '0' do
      show_legal_notes_footer(2)
    end
  end

  test 'should render legal notes external link' do
    Setting.plugin_redmine_legal_notes = { legal_notice_link: '',
                                           data_privacy_policy_link: 'http://example.net/data-privacy' }
    with_settings login_required: '0' do
      show_legal_notes_footer(1)
    end
  end

  test 'should render legal notice external link' do
    Setting.plugin_redmine_legal_notes = { legal_notice_link: 'http://example.net/legal-notice',
                                           data_privacy_policy_link: '' }
    with_settings login_required: '0' do
      show_legal_notes_footer(1)
    end
  end

  test 'should render both external links' do
    Setting.clear_cache
    Setting.plugin_redmine_legal_notes = { legal_notice_link: 'http://example.net/legal-notice',
                                           data_privacy_policy_link: 'http://example.net/data-privacy' }
    with_settings login_required: '0' do
      show_legal_notes_footer(2)
    end
  end

  test 'should prefer pages over external links' do
    Setting.clear_cache
    Setting.plugin_redmine_legal_notes = { legal_notice_link: 'http://example.net/legal-notice',
                                           data_privacy_policy_link: 'http://example.net/data-privacy',
                                           legal_notice: 'Legal Notes',
                                           data_privacy_policy: 'Data Privacy Policy' }
    with_settings login_required: '0' do
      show_legal_notes_footer(2)
      assert_select 'a[href=?]', relative_link('legal-notice')
      assert_select 'a[href=?]', relative_link('data-privacy-policy')
    end
  end

  private

  def relative_link(page_name)
    return "/legal_notes?name=#{page_name}" if Rails.version > '6'

    "/#{page_name}"
  end

  def show_legal_notes_footer(count)
    get home_path
    assert_response :success
    assert_select '.legal-notes-link' do
      assert_select 'a', count
    end
  end
end
