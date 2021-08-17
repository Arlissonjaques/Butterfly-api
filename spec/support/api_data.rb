def authentication_headers
    FactoryBot.create(:user).create_new_auth_token
end