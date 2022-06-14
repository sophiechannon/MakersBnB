feature "listing a space" do
  scenario "listing a space on /space/new route" do
    visit("/spaces/new")
    save_and_open_page
    fill_in("property_name", with: "A beautiful house")
    fill_in("description", with: "A beautiful house by the river")
    click_button "List my Space"

    expect(current_path).to eq '/spaces'
    expect(page).to have_content "A beautiful house"
    expect(page).to have_content "A beautiful house by the river"
  end
end
