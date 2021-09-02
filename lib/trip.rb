class Trip
  attr_accessor :driver_name
  attr_accessor :trip_start
  attr_accessor :trip_end
  attr_accessor :trip_length

  def initialize(driver_name, trip_start, trip_end, trip_length)
    @driver_name = driver_name
    @trip_start = trip_start
    @trip_end = trip_end
    @trip_length = trip_length
  end
end