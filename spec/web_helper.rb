def list_a_property(name:, description:, price:)
  visit("/spaces/new")
  fill_in("property_name", with: name)
  fill_in("description", with: description)
  fill_in("price", with: price)
  click_button "List my Space"
end
