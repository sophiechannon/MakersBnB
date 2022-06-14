feature "viewing properties" do
  scenario "viewing properties on /spaces route" do
    visit("/spaces")
    expect(page).to have_content "Book a space"
    expect(page).to have_content "Property 1"
  end
end
