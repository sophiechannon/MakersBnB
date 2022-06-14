require 'pg'

class Property
  
  attr_reader :name, :description

  def initialize(name:,description:)
    @name = name
    @description = description
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec_params(
      "SELECT * from properties", []
    )
    result.map{ |entry|
      Property.new(name: entry['property_name'], description: entry['property_description'])
    }
  end
end
