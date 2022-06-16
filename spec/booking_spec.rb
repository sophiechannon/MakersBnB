require "./lib/booking"

describe Booking do
  describe ".create" do
    it "should create a pending booking" do
      user = User.create(first_name: "Iain", last_name: "Banks", email: "iain@test.com", password: "password123")
      property = Property.create(name: "A haunted house by the sea", description: "It is an old haunted house, you will definitely love the fear.",
                                 price: "25", user_id: user.id, availability_start: "2022-06-20", availability_end: "2022-06-30")

      booking = Booking.create(user_id: user.id, date: "2022-06-30", property_id: property.id)
      expect(booking.property_id).to eq property.id
      expect(booking.booker_id).to eq user.id
      expect(booking.status).to eq "PENDING"
      expect(booking.booking_date).to eq "2022-06-30"
    end
  end
end
