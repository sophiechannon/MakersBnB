require "pg"

class Property
  attr_reader :id, :name, :description, :price, :user_id

  def initialize(id:, name:, description:, price:, user_id:)
    @id = id
    @name = name
    @description = description
    @price = price
    @user_id = user_id
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
      Property.new(id: entry["id"], name: entry["property_name"], description: entry["property_description"], price: entry["price_per_night"], user_id: entry["user_id"])
    }
  end

  def self.create(name:, description:, price:, user_id:)
    if ENV["ENVIRONMENT"] == "test"
      @connection = PG.connect(dbname: "makersbnb_test")
    else
      @connection = PG.connect(dbname: "makersbnb")
    end
    result = @connection.exec_params(
      "INSERT INTO properties (property_name, property_description, price_per_night, user_id) VALUES($1, $2, $3, $4) RETURNING id, property_name, property_description, price_per_night, user_id",
      [name, description, price, user_id]
    )
    Property.new(id:result[0]["id"], name: result[0]["property_name"], description: result[0]["property_description"], price: result[0]["price_per_night"], user_id: result[0]["user_id"])
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
      user_id: result[0]["user_id"]
    )
  end
end
