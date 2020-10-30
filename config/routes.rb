# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :legal_notes,
          path: ':legal_note',
          legal_note: /#{RedmineLegalNotes.defaults.keys.join('|')}/,
          only: :index
