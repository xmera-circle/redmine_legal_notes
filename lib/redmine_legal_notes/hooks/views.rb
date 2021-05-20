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

module RedmineLegalNotes
  module Hooks
    ##
    # Implement some view hooks
    #
    class Views < Redmine::Hook::ViewListener

      ##
      # Inject custom css for the footer into head
      #
      render_on :view_layouts_base_html_head,
                partial: 'legal_notes/base_html_head'

      ##
      # Render privacy consent in users/_form.html.erb
      #
      def view_users_form(context = {})
        render_privacy_consent(context)
      end

      ##
      # Render privacy consent in may/account.html.erb
      #
      def view_my_account(context = {})
        render_privacy_consent(context)
      end

      private

      def render_privacy_consent(context)
        context[:controller].send :render_to_string, {
          partial: 'account/privacy_consent',
          locals: { user: context[:user], f: context[:form] }
        }
      end
    end
  end
end
