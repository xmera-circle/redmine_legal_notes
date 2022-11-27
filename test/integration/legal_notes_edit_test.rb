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
# The plugins setting page should be accessable.
#
class LegalNotesEditTest < ActionDispatch::IntegrationTest
  include RedmineLegalNotes::AuthenticateUser
  include RedmineLegalNotes::LoadFixtures

  fixtures :users, :email_addresses, :roles

  test 'admin can edit legal notes' do
    Redmine::Plugin.register :redmine_legal_notes unless Redmine::Plugin.installed? :redmine_legal_notes

    log_user('admin', 'admin')
    get '/settings/plugin/redmine_legal_notes'
    assert_response :success
  end
end
