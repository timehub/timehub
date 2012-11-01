require 'spec_helper'

describe API::Base do

  let(:api) { API::Base.new("token", "path") }
  let(:options) { {:page=>1, :per_page=>2} }
  
  let(:http_party) do
    parsed_response = [{:commit => {:message => "Hello"}}]
    mock(:http_party, :code => 200, :parsed_response => parsed_response)
  end


  describe "#load" do
    before(:each) do
      api.stub(:httparty_response).and_return(http_party)
      API::Base.should_receive(:get).with(any_args())
                                    .and_return(api.httparty_response)
    end

    context "with valid options" do
      it "returns an array of commits" do
        api.load(options).should eql(api.httparty_response.parsed_response)
      end
    end

    context "with invalid options" do
      it "raises a Github::NotFound exception" do
        api.httparty_response.stub(:code).and_return(404)
        lambda { api.load(options) }.should raise_error(::Github::NotFound)
      end
    end
  end
end
