require "pg"

feature "viewing properties" do
  scenario "viewing properties on /spaces route" do
    connection = PG.connect(dbname: 'makersbnb_test')
    connection.exec_params(
      "INSERT INTO properties (property_name) VALUES($1)",
      ['A haunted house by the sea']
    )
    connection.exec_params(
      "INSERT INTO properties (property_name) VALUES($1)",
      ['A house in the moutains']
    )
    
    visit("/spaces")
    expect(page).to have_content "Book a space"
    expect(page).to have_content "A haunted house by the sea"
    expect(page).to have_content "A house in the moutains"
  end
end
