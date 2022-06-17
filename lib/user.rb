require "bcrypt"

class User
  attr_reader :id, :first_name, :last_name, :email

  def initialize(id, first_name, last_name, email)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
  end

  def self.create(first_name:, last_name:, email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (first_name, last_name, email_address, password) VALUES($1, $2, $3, $4) RETURNING id, first_name, last_name, email_address",
                                     [first_name, last_name, email, encrypted_password])
    User.new(result[0]["id"],
             result[0]["first_name"],
             result[0]["last_name"],
             result[0]["email_address"])
  end

  def self.authenticate(email:, password:)
    result = DatabaseConnection.query("SELECT * FROM users WHERE email_address = $1", [email])
    return nil unless result.any?
    return nil unless BCrypt::Password.new(result[0]["password"]) == password
    User.new(result[0]["id"],
             result[0]["first_name"],
             result[0]["last_name"],
             result[0]["email_address"])
  end

  def self.find(id:)
    return nil if id == nil
    result = DatabaseConnection.query(
      "SELECT * FROM users WHERE id = $1",
      [id]
    )
    User.new(result[0]["id"],
             result[0]["first_name"],
             result[0]["last_name"],
             result[0]["email_address"])
  end
end
