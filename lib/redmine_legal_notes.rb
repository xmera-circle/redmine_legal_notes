# frozen_string_literal: true

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
    attr = []
    attr.inject(&:merge)
  end
end
