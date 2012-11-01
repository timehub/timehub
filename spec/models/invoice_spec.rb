require 'spec_helper'

describe Invoice do

  context "Instance Methods (without hooks)" do
    let(:invoice) { Factory(:invoice) }

    describe "#total_minutes" do
      it "sums all the entries' minutes" do
        invoice.total_minutes.should eql(125)
        invoice.entries << Factory(:time_entry, :invoice => invoice, :minutes => 55)
        invoice.reload.total_minutes.should eql(180)
      end
    end

    describe "#total_hours" do
      it "Should round to 2 decimals" do
        invoice.stub(:total_minutes).and_return(125)
        invoice.total_hours.should eql(2.08)
      end
    end

    describe "#formatted_minutes" do
      it "should return 0:00 with no entries" do
        invoice.stub(:entries).and_return([])
        invoice.formatted_minutes.should eql("0:00")
      end

      it "should return H:MM if it's less than 10 hours" do
        invoice.stub(:total_minutes).and_return(599)
        invoice.formatted_minutes.should eql("9:59")
      end

      it "should return HH:MM if it's at least 10 hours" do
        invoice.stub(:total_minutes).and_return(600)
        invoice.formatted_minutes.should eql("10:00")
      end
    end

    describe "#total" do
      it "returns a floating number" do
        invoice.stub(:total_hours).and_return(6)
        invoice.stub(:rate).and_return(10)
        invoice.total.should be_kind_of(Float)
      end

      it "should multiply the rate * total_hours" do
        invoice.stub(:total_hours).and_return(6)
        invoice.stub(:rate).and_return(10)
        invoice.total.should eql(60.0)
      end
    end
  end
  
  describe "#build_entries_from_commits" do
    let(:project)         { Factory(:project, :rate => 30) }
    let(:commit)          { Factory(:commit, :project => project) }
    let(:another_commit)  { Factory(:commit, :project => project) }
    let(:invoice)         { Factory(:invoice, :project => project) }
    
    it "creates an entry for each commit" do
      invoice.build_entries_from_commits( [commit.id] )
      invoice.entries.count.should eql(1)
    end
    
        
  end

  describe "#set_rate" do
    let(:project) { Factory(:project, :rate => 30) }
    let(:invoice) { Factory.build(:invoice, :project => project, :rate => 35.0) }

    it "takes the project's rate if not present" do
      invoice.rate = nil
      invoice.save
      invoice.reload.rate.should eql(project.rate)
    end

    it "takes the setted rate if present" do
      invoice.save
      invoice.rate.should eql(35.0)
    end
  end

end
