# frozen_string_literal: true

module RedmineLegalNotes
  module Hooks
    # Inject custom css for the footer into head
    class ViewLayoutsHook < Redmine::Hook::ViewListener
      render_on :view_layouts_base_html_head,
                partial: 'legal_notes/base_html_head'
    end
  end
end
