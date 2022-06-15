feature "User log in" do
  scenario "allows a user to log in" do
    User.create(first_name: "Ian", last_name: "Banks", email: "iain@test.com", password: "password123")
    visit "/"
    click_link "Log in"
    fill_in :email, with: "iain@test.com"
    fill_in :password, with: "password123"
    click_button "Log in"
    expect(page).not_to have_content "Log into MakersBnB"
    expect(page).to have_content "Book a space"
  end

  scenario "user enters wrong details" do
    User.create(first_name: "Ian", last_name: "Banks", email: "iain@test.com", password: "password123")
    visit "/"
    click_link "Log in"
    fill_in :email, with: "wrong@test.com"
    fill_in :password, with: "password123"
    click_button "Log in"
    expect(page).to have_content "Log into MakersBnB"
    expect(page).not_to have_content "Book a space"
  end
end
