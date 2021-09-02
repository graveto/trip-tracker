class Driver
  attr_accessor :name
  attr_accessor :trips
  attr_accessor :total_distance_traveled
  attr_accessor :total_time_traveled
  attr_accessor :average_speed

  def initialize(name, trips)
    @name = name
    @trips = trips
    @total_distance_traveled = 0
    @total_time_traveled = 0
    @average_speed = 0
  end
end