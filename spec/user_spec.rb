describe User do
  describe ".create" do
    it "adds a new user to the database" do
      user = User.create(first_name: "Iain", last_name: "Banks", email: "iain@test.com", password: "password123")
      expect(user.first_name).to eq "Iain"
    end
  end
end
