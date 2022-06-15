feature "User logs out" do 
  scenario "Allows a user to log in and log out" do 
    User.create(first_name: "Ian", last_name: "Banks", email: "iain@test.com", password: "password123")
    visit '/'
    click_link 'Log in'
    fill_in :email, with: 'iain@test.com'
    fill_in :password, with: 'password123'
    click_button 'Log in'
    expect(page).not_to have_content 'Log in'
    expect(page).to have_content 'Sign out'
    click_link "Sign out"
    expect(page).not_to have_content 'Sign out'
    expect(page).to have_content 'Log in'
  end
end