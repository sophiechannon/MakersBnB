require "pg"

class Property
  attr_reader :name, :description, :price

  def initialize(name:, description:, price:)
    @name = name
    @description = description
    @price = price
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
      Property.new(name: entry["property_name"], description: entry["property_description"], price: entry["price_per_night"])
    }
  end

  def self.create(name:, description:, price:)
    if ENV["ENVIRONMENT"] == "test"
      @connection = PG.connect(dbname: "makersbnb_test")
    else
      @connection = PG.connect(dbname: "makersbnb")
    end
    result = @connection.exec_params(
      "INSERT INTO properties (property_name, property_description, price_per_night) VALUES($1, $2, $3) RETURNING property_name, property_description, price_per_night",
      [name, description, price]
    )
    Property.new(name: result[0]["property_name"], description: result[0]["property_description"], price: result[0]["price_per_night"])
  end
end
