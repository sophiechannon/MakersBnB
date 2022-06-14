feature "user registration" do
  scenario "user signs up via the homepage" do
    visit '/'
    user_sign_up
    expect(page).not_to have_content "Sign up to MakersBnB"
    expect(page).to have_content "Book a space"
  end
end