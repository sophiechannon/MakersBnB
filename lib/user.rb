class User
  attr_reader :first_name, :last_name, :email
  
  def initialize(first_name, last_name, email)
    @first_name = first_name
    @last_name = last_name
    @email = email
  end

  def self.create(first_name:, last_name:, email:, password:)
    User.new(first_name, last_name, email)
  end
end