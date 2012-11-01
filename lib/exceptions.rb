module Github
  # Basic Github Error
  class Error < StandardError; end

  # This error should be raised when Github returns a 404.
  # For example, a user has deleted a repo from Github and
  # tries to fetch commits from there.
  #
  # You can add the path and query of the request and an optional message
  class NotFound < Error
    attr_reader :path, :query
    attr_writer :default_message

    def initialize(path = nil, query = nil, message = nil)
      @path = path
      @query = query
      @message = message
      @default_message = I18n.t(:"github.not_found.default", :default => "Oops the repo you're looking for is not longer present in GitHub.")
    end

    def to_s
      @message || @default_message
    end
  end
end
