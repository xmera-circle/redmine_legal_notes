# frozen_string_literal: true

# This file is part of the Plugin Redmine Legal Notes.
#
# Copyright (C) 2022-2023 Liane Hampe <liaham@xmera.de>, xmera Solutions GmbH.
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

class LegalNotePresenter < AdvancedPluginHelper::BasePresenter
  presents :legal_note

  def link_to_legal_notes
    "#{link_to_legal_note} #{delimiter} #{link_to_data_privacy_policy}".html_safe
  end

  private

  def link_to_legal_note
    label = l(:label_legal_notice)
    if legal_note.find(name: 'legal-notice').present?
      link_to(label, legal_notes_path(name: 'legal-notice'))
    else
      legal_notice_link.present? ? sanitize(link_to(label, legal_notice_link)) : ''
    end
  end

  def link_to_data_privacy_policy
    label = l(:label_data_privacy_policy)
    if legal_note.find(name: 'data-privacy-policy').present?
      link_to(label, legal_notes_path(name: 'data-privacy-policy'))
    else
      data_privacy_policy_link.present? ? sanitize(link_to(label, data_privacy_policy_link)) : ''
    end
  end

  def delimiter
    return unless link_to_legal_note.presence
    return unless link_to_data_privacy_policy.presence

    '|'
  end

  def legal_notice_link
    legal_note.find(name: 'legal_notice_link')
  end

  def data_privacy_policy_link
    legal_note.find(name: 'data_privacy_policy_link')
  end
end
