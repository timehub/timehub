require 'spec_helper'

describe Project do
  it "should have a valid factory" do
    Factory.build(:project).should be_valid
  end
end
