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

# Target is redmines app/views/layouts/base.html.erb file
Deface::Override.new(
  virtual_path: 'layouts/base',
  name: 'add-legal-notes-to-footer-content',
  replace: '#footer',
  partial: 'legal_notes/footer',
  original: 'a792e18b9fe20c73572a7bf7684df03c353df976',
  sequence: '1',
  namespaced: true
)
