require "pg"

feature "viewing properties" do
  scenario "viewing properties on /spaces route" do
    list_a_property(name: 'A haunted house by the sea', description: 'It is an old haunted house, you will definitely love the fear. Enjoy the night!')
    list_a_property(name: 'A house in the moutains', description: 'A big house in the mountains. You will enjoy the views and the songs of the birds.')
    visit("/spaces")
    expect(page).to have_content "Book a space"
    expect(page).to have_content "A haunted house by the sea"
    expect(page).to have_content "It is an old haunted house, you will definitely love the fear. Enjoy the night!"
    expect(page).to have_content "A house in the moutains"
    expect(page).to have_content "A big house in the mountains. You will enjoy the views and the songs of the birds."
  end
end
