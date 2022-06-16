require 'pg'

class Booking


  def self.create(user_id:, date:, property_id:)
    if ENV["ENVIRONMENT"] == "test"
      @connection = PG.connect(dbname: "makersbnb_test")
    else
      @connection = PG.connect(dbname: "makersbnb")
    end
    @connection.exec_params(
      "INSERT INTO bookings (booker_id, booking_date, booking_status, property_id) VALUES($1, $2, $3, $4)",
      [user_id, date, "PENDING", property_id]
    )
  end
end