# frozen_string_literal: true

# This file is part of the Plugin Redmine Legal Notes.
#
# Copyright (C) 2021 Liane Hampe <liaham@xmera.de>, xmera.
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

require File.expand_path('../test_helper', __dir__)
require File.expand_path("#{File.dirname(__FILE__)}/../load_fixtures")

module RedmineIssueSync
  class SynchronisationTest < ActiveSupport::TestCase
    include RedmineLegalNotes::LoadFixtures

    fixtures :users, :email_addresses

    def setup
      Setting.plugin_redmine_legal_notes[:enable_privacy_consent] = nil
      @user = User.find(2)
    end

    test 'should have privacy_consent as safe attribute' do
      assert @user.safe_attribute? :privacy_consent
    end

    test 'should validate privacy_consent if enabled' do
      Setting.plugin_redmine_legal_notes[:enable_privacy_consent] = 'true'
      assert_not @user.valid?
      assert_equal %i[privacy_consent], @user.errors.keys
    end

    test 'should not validate privacy_consent if not enabled' do
      assert @user.valid?
    end
  end
end