require 'spec_helper'

describe Activity do
  it "should have a valid factory" do
    Factory.build(:activity).should be_valid
  end
end
