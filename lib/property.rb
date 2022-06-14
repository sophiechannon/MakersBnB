require 'pg'

class Property
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
      entry['property_name']
    }
  end
end
