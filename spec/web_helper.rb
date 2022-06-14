def user_sign_up
  fill_in :first_name, with: "Iain"
  fill_in :last_name, with: "Banks"
  fill_in :email, with: "ian@test.com"
  fill_in :password, with: "password123"
  click_button "Sign up"
end