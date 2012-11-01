require 'exceptions'

class API::Base
  include HTTParty
  base_uri 'https://api.github.com'

  attr_accessor :httparty_response, :parsed_response, :path

  def initialize(oauth_token, path)
    self.class.default_params :access_token => oauth_token
    self.path = path
  end

  def load(query = { :per_page => 100 })
    self.httparty_response = self.class.get(self.path, :query => query)
    if self.httparty_response.code != 200
      raise ::Github::NotFound.new(self.path, query)
    else
      self.parsed_response = httparty_response.parsed_response
    end
  end

  # Parses something like:
  # Link: <https://api.github.com/repos?page=3&per_page=100>; rel="next", <https://api.github.com/repos?page=50&per_page=100>; rel="last"
  def next_page_url
    return nil if link_header.blank? # No Link header
    next_link = link_header.split(",").detect { |s| s =~ /next/ }
    return nil if next_link.blank? # No Next link in Link header
    next_link = next_link.split(";").first
    raise "Invalid next page parameter" unless next_link =~ /\A<(http.+)>\z/
    $1
  end
  
  def next_page
    return nil if next_page_url.blank?
    self.class.new(self.class.default_params[:access_token], next_page_url)
  end
  
  protected
  
  def link_header
    self.httparty_response.headers["link"]
  end
end