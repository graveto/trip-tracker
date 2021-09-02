require "trip_tracker"

describe TripTracker do
  describe ".convert_time_to_secs" do
    context "given time in hours:minutes convert it to seconds" do
      it "returns time in seconds" do
        expect(TripTracker.convert_time_to_secs("7:45")).to eql(27900)
      end
    end
  end

  describe ".calculate_time" do
    context "given a start and an end time calculate total time spent traveling" do
      context "given start hour and end hour are the same" do
        it "returns total time traveled" do
          expect(TripTracker.calculate_time("7:15", "7:45")).to eql(1800)
        end
      end
      context "given start hour is smaller then end hour and start minute is smaller than the end minute" do
        it "returns total time traveled" do
          expect(TripTracker.calculate_time("7:15", "8:45")).to eql(5400)
        end
      end
      context "given start hour is smaller then end hour and start minute is bigger than the end minute" do
        it "returns total time traveled" do
          expect(TripTracker.calculate_time("7:56", "8:07")).to eql(660)
        end
      end 
      context "given start hour is bigger then end hour and the start minute is smaller then the end minute" do
        it "returns total time traveled" do
          expect(TripTracker.calculate_time("18:45", "07:52")).to eql(47220)
        end
      end     
      context "given start hour is bigger then end hour" do
        it "returns total time traveled" do
          expect(TripTracker.calculate_time("16:45", "15:23")).to eql(81480)
        end
      end
    end
  end

  describe "#calculate_distance" do
    context "given array of distances" do
      it "returns rounded down total distance traveled for decimal part less then 0.5" do
        expect(TripTracker.calculate_distance([56.1, 47.3])).to eql(103)
      end
      it "returns rounded up total distance traveled for decimal part greater then 0.5" do
        expect(TripTracker.calculate_distance([56.2, 47.3])).to eql(104)
      end
    end
  end

  describe ".calculate_speed" do
    context "given distance in miles and time in seconds" do
      it "returns speed in miles per hour rounded to the nearest integer" do
        expect(TripTracker.calculate_speed(230, 19380)).to eql("43 mph")
      end
    end
  end
  
  describe ".format_time" do
    context "given time in seconds" do
      it "returns time in hours:minutes format" do
        expect(TripTracker.format_time(81480)).to eql("22:38")
      end
    end
  end

  describe ".parse_file" do
    context "given input.txt" do
      it "returns hash of drivers" do
        expect(TripTracker.parse_file("input.txt").class.to_s).to eql("Hash")  
      end
    end
  end

  describe ".create_output" do
    context "given hash of drivers" do
      it "it returns new file" do
        expect(Dir.glob(File.join(File.expand_path("./"), "trip_tracker.txt")).length).to eql(1)
      end
    end
  end
end