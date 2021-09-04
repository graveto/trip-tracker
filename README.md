# About trip-tracker
trip-tracker generates a report about driver's trip length and the average speed of their trip. It consumes a text file that holds driver's name, the distance traveled and start and end of each trip. From this information it calculates the total distance traveled by each trip and the average speed of their trips. The generated report does not include trips with average speed less than 5 mph and more than 100 mph.

# How to run the application
ruby lib/trip_tracker.rb input.txt

# How I test the application
bundle exec rspec spec


