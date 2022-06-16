require "pg"

feature "viewing properties" do
  scenario "viewing properties on /spaces route" do
    user_log_in
    list_a_property(name: "A haunted house by the sea", description: "It is an old haunted house, you will definitely love the fear. Enjoy the night!", price: "50", availability_start: "2022-06-14", availability_end: "2022-06-30" )
    list_a_property(name: "A house in the moutains", description: "A big house in the mountains. You will enjoy the views and the songs of the birds.", price: "100",availability_start: "2022-06-18", availability_end: "2022-06-28")

    expect(page).to have_content "Book a space"
    expect(page).to have_content "A haunted house by the sea"
    expect(page).to have_content "It is an old haunted house, you will definitely love the fear. Enjoy the night!"
    expect(page).to have_content "£50"
    expect(page).to have_content "iain@test.com"
    expect(page).to have_content "from:2022-06-14"
    expect(page).to have_content "until:2022-06-30"
    expect(page).to have_content "A house in the moutains"
    expect(page).to have_content "A big house in the mountains. You will enjoy the views and the songs of the birds."
    expect(page).to have_content "£100"
  end

  scenario "If a user trys to enter a end date that is before start date" do
    user_log_in
    list_a_property(name: "A haunted house by the sea", description: "It is an old haunted house, you will definitely love the fear. Enjoy the night!", price: "50", availability_start: "2022-06-14", availability_end: "2022-06-12" )
    save_and_open_page   
    expect(current_path).to eq "/spaces/new" 
    expect(page).to have_content "Date is before start date"
  
  end
end
