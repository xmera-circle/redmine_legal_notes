# frozen_string_literal: true

module RedmineLegalNotes
  module LoadFixtures
    module_function

    class << self
      def fixtures(*table_names)
        dir = File.join( File.dirname(__FILE__), '/fixtures')
        table_names.each do |file|          
          create_fixtures(dir, file) if File.exist?("#{dir}/#{file}.yml")
        end
        super(table_names)
      end

      private

      def create_fixtures(dir, file)
        ActiveRecord::FixtureSet.create_fixtures(dir, file)
      end
    end
  end
end