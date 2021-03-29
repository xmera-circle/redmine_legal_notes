# frozen_string_literal: true

plugins = %w(redmine_project_types redmine_news_blog redmine_wiki_page_reorder)

unless plugins.any? { |plugin| Dir.exist?(File.expand_path("../../#{plugin}", __FILE__)) }
  gem 'deface', '1.6.2'
end