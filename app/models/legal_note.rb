# frozen_string_literal: true

##
# Interface for LegalNote business
#
class LegalNote
  class << self
    def find(name:)
      content_of(name) if valid? name
    end

    def names
      RedmineLegalNotes.defaults.keys
    end

    private

    def content_of(name)
      setting.fetch(name, default_for(name))
    end

    def setting
      Setting.send('plugin_redmine_legal_notes')
    end

    def default_for(name)
      RedmineLegalNotes.defaults[name.to_sym]
    end

    def valid?(name)
      names.include? name.to_sym
    end
  end
end
