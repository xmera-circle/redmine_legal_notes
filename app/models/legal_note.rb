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
