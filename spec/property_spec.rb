require "./lib/property"

describe Property do
  describe ".all" do
    it "shows all spaces" do
      user = User.create(first_name: "Iain", last_name: "Banks", email: "iain@test.com", password: "password123")
      Property.create(name: "A haunted house by the sea", description: "It is an old haunted house, you will definitely love the fear.",
                      price: "25", user_id: user.id, availability_start: "2022-06-20", availability_end: "2022-06-30")
      Property.create(name: "A house in the moutains", description: "A big house in the mountains. You will enjoy the views and the songs of the birds.",
                      price: "50", user_id: user.id, availability_start: "2022-06-20", availability_end: "2022-06-30")

      result = Property.all
      expect(result.length).to eq 2
      expect(result.first).to be_a Property
      expect(result.first.name).to eq "A haunted house by the sea"
      expect(result.first.description).to eq "It is an old haunted house, you will definitely love the fear."
      expect(result.first.user_id).to eq user.id
      expect(result.first.availability_start).to eq "2022-06-20"
      expect(result.first.availability_end).to eq "2022-06-30"
    end
  end

  describe ".create" do
    it "creates a new property" do
      user = User.create(first_name: "Iain", last_name: "Banks", email: "iain@test.com", password: "password123")
      property = Property.create(name: "A haunted house by the sea", description: "It is an old haunted house, you will definitely love the fear.",
                                 price: "25", user_id: user.id, availability_start: "2022-07-20", availability_end: "2022-07-30")
      expect(Property.all.first.name).to eq "A haunted house by the sea"
      expect(Property.all.first.description).to eq "It is an old haunted house, you will definitely love the fear."
      expect(Property.all.first.price).to eq "25"
      expect(Property.all.first.user_id).to eq user.id
    end
  end
end
