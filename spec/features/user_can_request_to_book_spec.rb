feature "booking a space" do
  scenario "user sucessfully books a space for one night" do
   user = User.create(first_name: "Ian", last_name: "Banks", email: "iain@test.com", password: "password123")
    Property.create(name: "A house in the moutains", description: "A big house in the mountains. You will enjoy the views and the songs of the birds.",
      price: "50", user_id: user.id, availability_start: "2022-05-10", availability_end: "2022-10-20")
    user_log_in
    first('.listing').click_button 'Request to book'
    fill_in :date, with: '17/06/2022'
    click_button "Request"
    expect(page).to have_content "Booking request has been submitted"
  end    
end