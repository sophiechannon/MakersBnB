feature "view requests" do
  scenario "showing requests to book the properties listed by user" do
    property_owner = User.create(first_name: "Property", last_name: "Owner", email: "property@owner.com", password: "password123")
    property = Property.create(name: "A house in the moutains", description: "A big house in the mountains. You will enjoy the views and the songs of the birds.",
                               price: "50", user_id: property_owner.id, availability_start: "2022-05-10", availability_end: "2022-10-20")
    user_log_in
    first(".listing").click_link
    fill_in :date, with: "2022-07-01"
    click_button "Request"
    click_link "Sign out"

    click_link "Log in"
    fill_in :email, with: "property@owner.com"
    fill_in :password, with: "password123"
    click_button "Log in"

    visit("/view-requests")
    expect(page).to have_content "Requests I've received"
    expect(page).to have_content "Property: A house in the moutains"
    expect(page).to have_content "Status: PENDING"
    expect(page).to have_content "Date requested: 2022-07-01"
  end
end
