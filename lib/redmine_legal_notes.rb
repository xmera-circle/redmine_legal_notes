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

require_relative 'redmine_legal_notes/extensions/user_patch'
require_relative 'redmine_legal_notes/overrides/settings_controller_patch'
require_relative 'redmine_legal_notes/hooks/plugin_hook'
require_relative 'redmine_legal_notes/hooks/view_hooks'

##
# Set up for the plugin's setting section to be integrated in the
# registration process in init.rb.
#
module RedmineLegalNotes
  PATCHES = {
    settings_controller: RedmineLegalNotes::Overrides::SettingsControllerPatch,
    user: RedmineLegalNotes::Extensions::UserPatch
  }.freeze

  class << self
    def setup
      apply_patches
    end

    def partial
      'settings/redmine_legal_notes_settings'
    end

    def defaults
      attr = [legal_notice, data_privacy_policy]
      attr.inject(&:merge)
    end

    def legal_notice
      { legal_notice: '' }
    end

    def data_privacy_policy
      { data_privacy_policy: '' }
    end

    def apply_patches
      PATCHES.each_key do |key|
        add_patches(classify(key), PATCHES[key]) if Rails.version >= '6.0'

        prepare_patches(classify(key), PATCHES[key]) if Rails.version < '6.0'
      end
    end

    private

    def classify(key)
      key.to_s.classify.constantize
    end

    def prepare_patches(klass, patch)
      Rails.configuration.to_prepare do
        RedmineProalphaIntegration.send :add_patches, klass, patch
      end
    end

    def add_patches(klass, patch)
      return if klass.included_modules.include?(patch)

      klass.include(patch) if extensions?(patch)
      klass.prepend(patch) if overrides?(patch)
    end

    def overrides?(patch)
      patch.to_s.split('::').include? 'Overrides'
    end

    def extensions?(patch)
      patch.to_s.split('::').include? 'Extensions'
    end
  end
end
