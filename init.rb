Redmine::Plugin.register :redmine_legal_notes do
  name 'Redmine Legal Notes Plugin'
  author 'Liane Hampe, xmera'
  description 'Dedicated pages for data privacy policy and legal notice'
  version '0.0.1'
  url 'https://circle.xmera.de/projects/redmine-legal-notes'
  author_url 'http://xmera.de'

  requires_redmine version_or_higher: '4.0.0'
end
