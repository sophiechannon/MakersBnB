feature 'User log in' do
  scenario 'allows a user to log in' do
    visit '/'
    click_link 'Log in'
    fill_in :email, with: 'test@test.com'
    fill_in :password, with: 'password123'
    click_button 'Log in'

    expect(page).to have_content 'Book a space'
    expect(page).not_to have_content 'Log into MakersBnB'

  end
end