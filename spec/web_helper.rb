def list_a_property(name:, description:, price:)
  visit("/spaces/new")
  fill_in("property_name", with: name)
  fill_in("description", with: description)
  fill_in("price", with: price)
  click_button "List my Space"
end

def user_sign_up
  fill_in :first_name, with: "Iain"
  fill_in :last_name, with: "Banks"
  fill_in :email, with: "ian@test.com"
  fill_in :password, with: "password123"
  click_button "Sign up"
end

def user_log_in
  User.create(first_name: "Ian", last_name: "Banks", email: "iain@test.com", password: "password123")
  visit "/"
  click_link "Log in"
  fill_in :email, with: "iain@test.com"
  fill_in :password, with: "password123"
  click_button "Log in"
end
