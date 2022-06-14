require "./lib/property"

describe Property do
  describe ".all" do
    it "shows all spaces" do
      connection = PG.connect(dbname: "makersbnb_test")
      connection.exec_params(
        "INSERT INTO properties (property_name, property_description) VALUES($1, $2)",
        ["A haunted house by the sea", "It is an old haunted house, you will definitely love the fear. Enjoy the night!"]
      )
      connection.exec_params(
        "INSERT INTO properties (property_name, property_description) VALUES($1, $2)",
        ["A house in the moutains", "A big house in the mountains. You will enjoy the views and the songs of the birds."]
      )
      result = Property.all
      expect(result.length).to eq 2
      expect(result.first).to be_a Property
      expect(result.first.name).to eq "A haunted house by the sea"
      expect(result.first.description).to eq "It is an old haunted house, you will definitely love the fear. Enjoy the night!"
    end
  end

  describe ".create" do
    it "creates a new property" do
      property = Property.create(name: "A haunted house by the sea", description: "It is an old haunted house, you will definitely love the fear",
                                 price: "25")
      expect(Property.all.first.name).to eq "A haunted house by the sea"
      expect(Property.all.first.description).to eq "It is an old haunted house, you will definitely love the fear"
      expect(Property.all.first.price).to eq "25"
    end
  end
end
