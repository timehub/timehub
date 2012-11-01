# Basic usage of this class:

# r = API::Repositories.new(oauth_token)
# r.load # Performs the request to Github
# r.repos # Returns the list of repositories
# 
# r.next_page # Returns a new API::Repositories that represents the next page

class API::Repositories < API::Base
  def initialize(oauth_token, path = "/user/repos")
    super(oauth_token, path)
  end
  alias_method :repos, :parsed_response
  
  def self.each_for_oauth_token(oauth_token, &block)
    repos = API::Repositories.new(oauth_token)
    while true
      repos.load.each do |repo|
        yield(repo)
      end
      repos = repos.next_page
      break if repos.nil?
    end
  end
end