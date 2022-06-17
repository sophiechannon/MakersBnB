describe PropertyFilter do
  it "returns one property that matches the date, but not the other" do
    user = User.create(first_name: "Iain", last_name: "Banks", email: "iain@test.com", password: "password123")
    prop_1 = Property.create(name: "A haunted house by the sea", description: "It is an old haunted house, you will definitely love the fear.",
      price: "25", user_id: user.id, availability_start: "2022-06-12", availability_end: "2023-05-13")
    prop_2 =Property.create(name: "A house in the moutains", description: "A big house in the mountains. You will enjoy the views and the songs of the birds.",
      price: "50", user_id: user.id, availability_start: "2022-08-02", availability_end: "2023-02-23")
    PropertyFilter.set_dates(start_date: "2022-07-12", end_date: "2022-08-01")
    result = PropertyFilter.dates
    expect(result.length).to eq(1)
    expect(result.first.name).to eq("A haunted house by the sea")
  end

  it "returns both properties if they both match" do
    user = User.create(first_name: "Iain", last_name: "Banks", email: "iain@test.com", password: "password123")
    prop_1 = Property.create(name: "A haunted house by the sea", description: "It is an old haunted house, you will definitely love the fear.",
      price: "25", user_id: user.id, availability_start: "2022-06-12", availability_end: "2023-05-13")
    prop_2 =Property.create(name: "A house in the moutains", description: "A big house in the mountains. You will enjoy the views and the songs of the birds.",
      price: "50", user_id: user.id, availability_start: "2022-07-31", availability_end: "2023-02-23")
    PropertyFilter.set_dates(start_date: "2022-07-12", end_date: "2022-08-01")
    result = PropertyFilter.dates
    expect(result.length).to eq(2)
    expect(result.first.name).to eq("A haunted house by the sea")
  end
end