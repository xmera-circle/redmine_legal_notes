# frozen_string_literal: true

# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :legal_notes,
          path: ':name',
          constraints: { name: LegalNote.slugs.join('|') },
          only: :index
