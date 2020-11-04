# frozen_string_literal: true

module RedmineLegalNotes
  module AuthenticateUser
    module_function

    def log_user(login, password)
      User.anonymous
      get "/login"
      assert_nil session[:user_id]
      assert_response :success

      post "/login", :params => {
          :username => login,
          :password => password
        }
      assert_equal login, User.find(session[:user_id]).login
    end
  end
end