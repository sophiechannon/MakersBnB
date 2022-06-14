
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
