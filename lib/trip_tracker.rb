#!/usr/bin/env ruby
require_relative "trip"
require_relative "driver"

class TripTracker 
  def self.run file
    create_output(parse_file(file))
  end

  def self.calculate_distance(distances)
    sum = 0
    distances.each do |distance|
      sum += distance
    end
    return sum.round
  end

  def self.convert_time_to_secs(time)
    split_time = time.split(":")
    hours = split_time.first.to_i
    minutes = split_time.last.to_i
    seconds = hours * 3600 + minutes * 60
  end

  def self.calculate_time(start_time, end_time)
    start_seconds = convert_time_to_secs start_time
    end_seconds = convert_time_to_secs end_time
    seconds_in_day = 24 * 3600   
    if start_seconds > end_seconds
      seconds = end_seconds + (seconds_in_day - start_seconds)
    else
      seconds = end_seconds - start_seconds 
    end
    return seconds
  end

  def self.calculate_speed(distance, time)
    hours = time.to_f / 3600
    speed = (distance / hours).round()
    return "#{speed} mph"
  end
  
  def self.format_time(time)
    hours = (time - (time % 3600)) / 3600
    minutes = (time % 3600) / 60
    formated_time = "#{hours}:#{minutes}"
  end

  def self.parse_file(file)
    drivers = Hash.new
    File.foreach(file) do |line|
      command = line.split(" ").first
      if command == "Driver"
        name = line.split(" ").last.downcase.to_sym
        if drivers[name] == nil
          drivers[name] = Driver.new(name.to_s.capitalize, [])
        end  
      else
        trip_keys = ["name", "start", "end", "distance"]
        trip_info = line.split(" ").drop(1)
        trip_object = Trip.new(trip_info[0], trip_info[1], trip_info[2], trip_info[3])
        driver = trip_object.driver_name.downcase.to_sym
        if drivers.key?(driver)
          drivers[driver].trips.push(trip_object) 
        else
          drivers[driver] = Driver.new(driver, [])
          drivers[driver].trips.push trip_object
        end   
      end
    end
    return drivers
  end

  def self.create_output(drivers)  
    f = File.open("trip_tracker.txt", "w")
    drivers_arr = []
    average_speed = 0
    drivers.each() do |key, val|
      distances = []
      trip_times = []
      if drivers[key].trips.count > 0
        drivers[key].trips.each() do |trip|
          distances.push(trip.trip_length.to_f)
          trip_times.push(calculate_time(trip.trip_start, trip.trip_end))
        end
        drivers[key].total_distance_traveled = calculate_distance(distances)
        drivers[key].total_time_traveled = trip_times.sum() 
        average_speed = calculate_speed(drivers[key].total_distance_traveled, drivers[key].total_time_traveled)
        drivers[key].average_speed = average_speed
        if(average_speed.to_i > 5 && average_speed.to_i < 100 )
          drivers_arr.push drivers[key]
        end
      end
      if(drivers[key].trips.count == 0)
        drivers_arr.push drivers[key]
      end
    end
    sorted_drivers = drivers_arr.sort_by(&:total_distance_traveled).reverse 
    sorted_drivers.each do |driver|
      if driver.total_distance_traveled > 0
        f.write("#{driver.name}: #{driver.total_distance_traveled} miles @ #{driver.average_speed}\n")
      else
        f.write("#{driver.name}: 0 miles\n")
      end
    end
    f.close
  end
end

if __FILE__ == $PROGRAM_NAME
  TripTracker.run ARGV.last
end