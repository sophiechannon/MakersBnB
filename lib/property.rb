require "pg"

class Property

  attr_reader :name, :description, :price, :user_id, :availability_start, :availability_end, :id

  def initialize(name:, description:, price:, user_id:, availability_start:, availability_end:, id:)

    @name = name
    @description = description
    @price = price
    @user_id = user_id
    @availability_start = availability_start
    @availability_end = availability_end
    @id = id
  end

  def self.all
    if ENV["ENVIRONMENT"] == "test"
      @connection = PG.connect(dbname: "makersbnb_test")
    else
      @connection = PG.connect(dbname: "makersbnb")
    end
    result = @connection.exec_params(
      "SELECT * from properties", []
    )
    result.map { |entry|

      Property.new(name: entry["property_name"], description: entry["property_description"], price: entry["price_per_night"], user_id: entry["user_id"], availability_start: entry["availability_start_date"], availability_end: entry["availability_end_date"], id: entry["id"])
    }
  end

  def self.create(name:, description:, price:, user_id:, availability_start:, availability_end:)
    if ENV["ENVIRONMENT"] == "test"
      @connection = PG.connect(dbname: "makersbnb_test")
    else
      @connection = PG.connect(dbname: "makersbnb")
    end
    result = @connection.exec_params(
      "INSERT INTO properties (property_name, property_description, price_per_night, user_id, availability_start_date, availability_end_date) VALUES($1, $2, $3, $4, $5, $6) RETURNING property_name, property_description, price_per_night, user_id, availability_start_date, availability_end_date, id", 
      [name, description, price, user_id, availability_start, availability_end]
    )
    Property.new(name: result[0]["property_name"], description: result[0]["property_description"], price: result[0]["price_per_night"], user_id: result[0]["user_id"], availability_start: result[0]["availability_start_date:"], availability_end: result[0]["availability_end_date"], id: result[0]["id"])
  end

  def self.find(id:)
    return nil if id == nil
    if ENV['ENVIRONMENT'] == 'test'
      @connection = PG.connect(dbname: 'makersbnb_test')
    else
      @connection = PG.connect(dbname: 'makersbnb')
    end
    result = @connection.exec_params(
      "SELECT * FROM properties WHERE id = $1",
      [id]
    )
    Property.new(
      id:result[0]["id"], 
      name: result[0]["property_name"], 
      description: result[0]["property_description"], 
      price: result[0]["price_per_night"], 
      user_id: result[0]["user_id"],
      availability_start: result[0]["availability_start_date"],
      availability_end: result[0]["availability_end_date"]
    )
  end
end
