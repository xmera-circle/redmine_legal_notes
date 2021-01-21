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

require 'redmine_legal_notes/legal_notes_helper'
require 'redmine_legal_notes/legal_notes_hooks'

##
# Set up for the plugin's setting section to be integrated in the
# registration process in init.rb.
#
module RedmineLegalNotes
  module_function

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
end
