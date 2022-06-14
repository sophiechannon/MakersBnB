feature "listing a space" do
  scenario "listing a space on /space/new route" do
    list_a_property(name: "A beautiful house", description: "A beautiful house by the river")

    expect(current_path).to eq "/spaces"
    expect(page).to have_content "A beautiful house"
    expect(page).to have_content "A beautiful house by the river"
  end
end
