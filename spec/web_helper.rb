
def list_a_property(name:, description:)
  visit("/spaces/new")
  fill_in("property_name", with: name)
  fill_in("description", with: description)
  click_button "List my Space"
end
