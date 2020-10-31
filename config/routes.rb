# frozen_string_literal: true

# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :legal_notes,
          path: ':name',
          legal_note: /#{LegalNote.names.join('|')}/,
          only: :index
