def database_connection
  if ENV['ENVIRONMENT'] == 'test'
    @connection = PG.connect(dbname: 'makersbnb_test')
  else
    @connection = PG.connect(dbname: 'makersbnb')
  end
end