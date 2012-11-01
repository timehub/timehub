class API::Commits < API::Base
  def initialize(oauth_token, username, repository)
    super(oauth_token, "/repos/#{username}/#{repository}/commits")
  end

  alias_method :commits, :parsed_response

  # Walks through every commit until it gets to the commit with sha == existing_sha.
  # Might perform several API calls to load them all.
  def self.each_new_until_existing(oauth_token, username, repository, existing_sha, &block)
    raise ArgumentError.new("existing_sha can't be blank") if existing_sha.blank?
    commits = API::Commits.new(oauth_token, username, repository)
    while true
      commits.load.each do |github_commit|
        yield(github_commit)
      end
      break if commits.parsed_response.collect { |c| c["sha"] }.include?(existing_sha)
      commits = commits.next_page
      break if commits.nil?
    end
  end

end