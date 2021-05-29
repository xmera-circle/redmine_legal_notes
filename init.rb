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

require_dependency 'redmine_legal_notes'

Redmine::Plugin.register :redmine_legal_notes do
  name 'Redmine Legal Notes Plugin'
  author 'Liane Hampe, xmera'
  description 'Dedicated pages for data privacy policy and legal notice'
  version '0.1.1'
  url 'https://circle.xmera.de/projects/redmine-legal-notes'
  author_url 'http://xmera.de'

  requires_redmine version_or_higher: '4.1.0'
  requires_redmine_plugin :redmine_base_deface, version_or_higher: '1.8.1'

  settings  partial: RedmineLegalNotes.partial,
            default: RedmineLegalNotes.defaults
end

overrides_dir = 'app/overrides'
Rails.application.paths[overrides_dir] ||= []
dir = "#{Redmine::Plugin.directory}/redmine_legal_notes/#{overrides_dir}"
Rails.application.paths[overrides_dir] << dir unless Rails.application.paths[overrides_dir].include?(dir)

Rails.configuration.to_prepare do
  unless Redmine.included_modules.include?(RedmineLegalNotes::Helpers)
    SettingsController.prepend(RedmineLegalNotes::Helpers)
  end
end
