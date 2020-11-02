# frozen_string_literal: true

##
# Interface for LegalNote business
#
class LegalNote
  class << self
    def find(name:)
      return content_of(name) if valid? name

      raise ActiveRecord::RecordNotFound
    end

    ##
    # Turn names into SEO friendly slugs
    #
    def slugs
      names.collect { |name| to_slug(name) }
    end

    private

    def to_slug(name)
      name.to_s.gsub('_', '-')
    end

    ##
    # Extract symobolized names
    # from the plugin settings default hash
    #
    def names
      RedmineLegalNotes.defaults.keys
    end

    def content_of(name)
      setting.fetch(to_key(name), default_for(name))
    end

    def setting
      Setting.send('plugin_redmine_legal_notes')
    end

    def to_key(name)
      name.to_s.gsub('-', '_').to_sym
    end

    def default_for(name)
      RedmineLegalNotes.defaults[to_key(name)]
    end

    def valid?(name)
      slugs.include? name.to_s
    end
  end
end
