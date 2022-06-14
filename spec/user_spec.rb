describe User do
  describe ".create" do
    it "adds a new user to the database" do
      user = User.create(first_name: "Iain", last_name: "Banks", email: "iain@test.com", password: "password123")
      expect(user.first_name).to eq "Iain"
      expect(user.last_name).to eq "Banks"
      expect(user.email).to eq "iain@test.com"
      
    end
  end
end
