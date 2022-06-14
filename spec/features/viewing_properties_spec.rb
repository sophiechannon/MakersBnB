require "pg"

feature "viewing properties" do
  scenario "viewing properties on /spaces route" do
    visit("/spaces")
    expect(page).to have_content "Book a space"
    expect(page).to have_content "A haunted house by the sea"
    expect(page).to have_content "Property 2"
  end
end
