require 'pg'

def setup_test_database
  # connect to the testing database, not dev database
  connection = PG.connect(dbname: 'makersbnb_test')
  # truncate the testing databases
  connection.exec('TRUNCATE bookings, properties, users;')
end