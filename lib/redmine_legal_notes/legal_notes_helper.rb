# frozen_string_literal: true

# This file is part of the Plugin Redmine Legal Notes.
#
# Copyright (C) 2020 Liane Hampe <circle@xmera.de>, xmera.
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

module RedmineLegalNotes
  ##
  # Override Module#prepended to inject the LegalNotesHelper module
  #
  module Helper
    def self.prepended(base)
      base.helper LegalNotesHelper
    end
    ##
    # Collection of helper methods for the plugin's settings 
    # view _redmine_legal_notes_settings.html.erb
    #
    module LegalNotesHelper
      def legal_notice_settings_tabs
        [{ name: 'legal_notice',
           partial: 'legal_notes/legal_notice',
           label: :label_legal_notice },
         { name: 'data_privacy_policy',
           partial: 'legal_notes/data_privacy_policy',
           label: :label_data_privacy_policy }]
      end
    end
  end
end
