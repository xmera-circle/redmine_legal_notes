# Target is redmines app/views/layouts/base.html.erb file
Deface::Override.new(
  virtual_path: 'layouts/base',
  name: 'add-legal-notes-to-footer-content',
  replace: '#footer',
  partial: 'legal_notes/footer',
  original: 'd66a9fa3928197fd35b69c740cd3838230f55c87',
  namespaced: true
)