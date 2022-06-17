require "pg"


class Booking
  attr_reader :id, :booker_id, :booking_date, :status, :property_id

  def initialize(id:, booker_id:, booking_date:, status:, property_id:)
    @id = id
    @booker_id = booker_id
    @booking_date = booking_date
    @status = status
    @property_id = property_id
  end

  def self.create(user_id:, date:, property_id:)
    database_connection
    result = @connection.exec_params(
      "INSERT INTO bookings (booker_id, booking_date, booking_status, property_id) VALUES($1, $2, $3, $4) RETURNING id, booker_id, booking_date, booking_status, property_id",
      [user_id, date, "PENDING", property_id]
    )
    Booking.new(id: result[0]["id"], booker_id: result[0]["booker_id"], booking_date: result[0]["booking_date"], property_id: result[0]["property_id"], status: result[0]["booking_status"])
  end
end
