feature "listing a space" do
  scenario "listing a space on /space/new route" do
    list_a_property(name: "A beautiful house", description: "A extremely beautiful house by the river", price: "25")

    expect(current_path).to eq "/spaces"
    expect(page).to have_content "A beautiful house"
    expect(page).to have_content "A extremely beautiful house by the river"
    expect(page).to have_content "£25"
  end
end
