describe User do
  describe ".create" do
    it "adds a new user to the database" do
      user = User.create(first_name: "Iain", last_name: "Banks", email: "iain@test.com", password: "password123")
      persisted_data = persisted_data(id: user.id)
      expect(user.first_name).to eq "Iain"
      expect(user.last_name).to eq "Banks"
      expect(user.email).to eq "iain@test.com"
      expect(user.id).to eq persisted_data['id']
    end

    it "hashs the password using BCrypt" do
      expect(BCrypt::Password).to receive(:create).with("password123")
      User.create(first_name: "Iain", last_name: "Banks", email: "iain@test.com", password: "password123")
    end
  end

  describe '.authenticate' do
    it 'returns a user and logs them in if correct email and password are given' do
      user = User.create(first_name: "Sophie", last_name: "Gilder", email: "test@gmail.com", password: "password123")
      authenticated_user = User.authenticate(email: 'test@gmail.com', password: 'password123')
      expect(authenticated_user.id).to eq user.id
    end

    it "returns nil if incorrect email given" do
      user = User.create(first_name: "Sophie", last_name: "Gilder", email: "test@gmail.com", password: "password123")
      expect(User.authenticate(email: 'wrong@gmail.com', password: 'password123')).to be_nil
    end

    it "returns nil if incorrect password given" do
      user = User.create(first_name: "Sophie", last_name: "Gilder", email: "test@gmail.com", password: "password123")
      expect(User.authenticate(email: 'test@gmail.com', password: 'wrong_password')).to be_nil
    end
  end


  describe '.find' do
    it 'finds the user with the user id' do
      user = User.create(first_name: "Sophie", last_name: "Gilder", email: "test@gmail.com", password: "password123")
      result = User.find(id: user.id)
      expect(result.first_name).to eq "Sophie"
      expect(result.email).to eq "test@gmail.com"
    end

    it 'returns nil if no user is found' do
      expect(User.find(id: nil)).to eq nil
    end
  end
end
