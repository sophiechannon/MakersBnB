require 'date'

class PropertyFilter
  def self.set_dates(start_date:, end_date:)
    @@start_date = start_date
    @@end_date = end_date
  end

  def self.start_date
    p @@start_date
    p @@end_date
    if @@start_date == nil
      @@start_date = Date.today
    else
      @@start_date = Date.parse(@@start_date)
    end
    @@start_date
  end

  def self.end_date
    if @@end_date == nil 
      @@end_date = DateTime.now.next_year(3).to_date
    else
      @@end_date = Date.parse(@@end_date)
    end
    @@end_date
  end

  def self.dates
    properties = Property.all
    properties.reject do |prop|
      (Date.parse(prop.availability_start) < self.start_date && Date.parse(prop.availability_end) < self.start_date) || (Date.parse(prop.availability_start) > self.end_date && Date.parse(prop.availability_end) > self.end_date)
    end
  end
end