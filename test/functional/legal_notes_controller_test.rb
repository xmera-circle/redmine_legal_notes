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
# Check successful rendering and redirections.
#
class LegalNotesControllerTest < ActionDispatch::IntegrationTest
  attr_reader :legal_notice_title, :legal_notice_name

  setup do
    self.legal_notice_title = 'Legal Notice'
    self.legal_notice_name = 'legal-notice'
    Setting.plugin_redmine_legal_notes = { legal_notice: legal_notice_title,
                                           data_privacy_policy: '' }
  end

  teardown do
    Setting.delete_all
    Setting.clear_cache
  end

  test 'should get index' do
    get legal_notes_path(name: legal_notice_name)
    assert_response :success
  end

  test 'should display html title' do
    get legal_notes_path(name: legal_notice_name)
    assert_select 'title', html_title
  end

  test 'should render text' do
    get legal_notes_path(name: legal_notice_name)
    assert_select 'p', legal_notice_title
    get legal_notes_path(name: 'data-privacy-policy')
    assert_redirected_to home_path
  end

  private

  attr_writer :legal_notice_title, :legal_notice_name

  def html_title
    "#{legal_notice_title} - #{Setting.app_title}"
  end
end
