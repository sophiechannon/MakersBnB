require 'pg'

class User
  attr_reader :id, :first_name, :last_name, :email

  def initialize(id, first_name, last_name, email)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
  end

  def self.create(first_name:, last_name:, email:, password:)
    if ENV['ENVIRONMENT'] == 'test'
      @connection = PG.connect(dbname: 'makersbnb_test')
    else
      @connection = PG.connect(dbname: 'makersbnb')
    end
    result = @connection.exec_params("INSERT INTO users (first_name, last_name, email_address, password) VALUES($1, $2, $3, $4) RETURNING id, first_name, last_name, email_address", 
    [first_name, last_name, email, password])
    User.new(result[0]['id'],
      result[0]['first_name'], 
      result[0]['last_name'], 
      result[0]['email_address']
    ) 
  end
end