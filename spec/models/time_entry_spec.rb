require 'spec_helper'

describe TimeEntry do

  describe "#formatted_minutes" do
    let(:time_entry) { Factory(:time_entry) }
    it "is of the form H:MM if is less than 10 hours" do
      time_entry.formatted_minutes.should match(/\d:\d\d/i)
    end

    it "is of the form HH:MM if is at least 10 hours" do
      time_entry.minutes = 600
      time_entry.formatted_minutes.should match(/\d\d:\d\d/i)
    end

    it "returns a 0X format when the minutes is less than 10" do
      time_entry.minutes = 5
      time_entry.formatted_minutes.should eql("0:05")
    end

    it "returns a 1 digit hour number if it's less than 10" do
      time_entry.minutes = 120
      time_entry.formatted_minutes.should eql("2:00")
    end
  end

  describe "#formatted_minutes" do
    let(:time_entry) { Factory.build(:time_entry) }
    it "accepts a HH:MM format" do
      time_entry.formatted_minutes = "2:30"
      time_entry.minutes.should eql(150)
    end
  end

  describe "#hours" do
    let(:time_entry) { Factory(:time_entry, :minutes => 137) }

    it "Rounds to 2 decimals" do
      time_entry.hours.should eql(2.28)
    end
  end
end
