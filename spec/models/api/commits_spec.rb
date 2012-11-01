require 'spec_helper'

describe API::Commits do
  describe "#each_new_until_existing" do
    it "raises an ArgumentError if the SHA is not present" do
      lambda { API::Commits.each_new_until_existing("OAUTH", "Username", "Repo") }.should raise_error(ArgumentError)
    end
  end
end
