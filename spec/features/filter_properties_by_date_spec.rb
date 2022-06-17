feature "filter properties by date" do
  scenario "dates entered are valid for one property only and resets" do
    user_log_in
    list_a_property(name: "A haunted house by the sea", description: "It is an old haunted house, you will definitely love the fear. Enjoy the night!", price: "50", availability_start: "2022-06-12", availability_end: "2022-05-13" )
    list_a_property(name: "A house in the moutains", description: "A big house in the mountains. You will enjoy the views and the songs of the birds.", price: "100",availability_start: "2022-08-02", availability_end: "2022-02-23")
    save_and_open_page
    fill_in :available_from, with: "2022-07-12"
    fill_in :available_to, with: "2022-08-01"
    click_button "List Spaces"
    expect(page).to have_content "Book a space"
    expect(page).not_to have_content "A haunted house by the sea"
    expect(page).not_to have_content "It is an old haunted house, you will definitely love the fear. Enjoy the night!"
    expect(page).not_to have_content "£50"
    expect(page).to have_content "iain@test.com"
    expect(page).not_to have_content "from:2022-06-14"
    expect(page).not_to have_content "until:2022-06-30"
    expect(page).to have_content "A house in the moutains"
    expect(page).to have_content "A big house in the mountains. You will enjoy the views and the songs of the birds."
    expect(page).to have_content "£100"
    click_button "Reset"
    expect(page).to have_content "A haunted house by the sea"
  end

end