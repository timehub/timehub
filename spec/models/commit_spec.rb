require 'spec_helper'

describe Commit do  
  describe "#estimated_minutes_from_message" do
    let(:commit) { Factory(:commit) }
    it "gets the right times" do
      data = {
        "[T: 2:03]" => 123, "[t:2:3]" => 123, "[t:2]" => 120,
        "[T: 3]" => 180, "[ t : 4]" => 240, "[  T:  5]" => 5, "[t:120]" => 120,
        "[t:2 : 03]" => 123, "[t: 2 : 03 ]" => 123,
        "[t:2h:03]" => 123, "[t:2:3min]" => 123, "[t:2h:3m]" => 123,
        "[t:2hours:3minutes]" => 123, "[t:2 hours:3 minutes]" => 123,
        "[t:2 hours : 3 minutes]" => 123, "[T: 2 HOURS : 3 MiNuTeS]" => 123,
        "[t:2h3m]" => 123, "[t:2h3]" => 123, "[t: 2 hours 3 minutes]" => 123,
        "[t:2h 3min]" => 123, "[t:2    hours       3 minutes ]" => 123,
        "[T:2 hours and 3 minutes]" => 123, "[t:2 h & 4 m]" => 124,
        "[t: 2h 5m ]" => 125, "[t:2 hours]" => 120, "[ t:2m]" => 2, 
        "[ T : 2 minutes]" => 2, "[ t: 2h]" => 120,
        "[1]" => nil, "[a]" => nil,
        "1" => nil, "fuck you! wha' abou' that?" => nil,
      }

      data.each do |message, expected_result|
        commit.message = "Winning the Rally on Rails #{message}"
        commit.send(:estimated_minutes_from_message).to_s.should == expected_result.to_s
      end
    end
  end

  describe "#estimated_minutes_from_parent_commit" do
    let(:parent) { Factory(:commit) }

    context "with at least one parent" do
      let(:commit) { Factory(:commit, :parents => [parent.sha], :project => parent.project) }

      it "returns the time between the parent and the commited_time" do
        commit.committed_at = parent.committed_at + 1.hours + 3.minutes
        commit.send(:estimated_minutes_from_parent_commit).should eql(63)
      end

      it "returns the maximum of the 2 parents" do
        another_parent = Factory(:commit, :project => commit.project, :committed_at => parent.committed_at - 5.minutes)

        commit.committed_at = parent.committed_at + 1.hours + 3.minutes
        commit.stub(:parents).and_return([parent.sha, another_parent.sha])
        commit.send(:estimated_minutes_from_parent_commit).should eql(68)
      end

      it "returns nil if the time elapsed is more than 120 minuts" do
        commit.committed_at = parent.committed_at + 2.hours + 1.minutes
        commit.send(:estimated_minutes_from_parent_commit).should eql(nil)
      end
    end

    context "with no parents" do
      let(:commit) { Factory(:commit) }
      it "returns nil with an empty parents array" do
        commit.stub(:parents).and_return([ ])
        commit.send(:estimated_minutes_from_parent_commit).should eql(nil)
      end

      it "returns nil if commit.parents is nil" do
        commit.stub(:parents).and_return(nil)
        commit.send(:estimated_minutes_from_parent_commit).should eql(nil)
      end
    end

  end
end
