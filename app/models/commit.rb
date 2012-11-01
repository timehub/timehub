class Commit < ActiveRecord::Base
  belongs_to :project
  has_many :entries, :class_name => "TimeEntry"
  
  paginates_per 30
  has_many :invoices, :through => :entries

  validates_presence_of :project_id, :committed_at, :message, :sha, :author_username
  validates_uniqueness_of :sha, :scope => [ :project_id ]
  
  serialize :parents, Array

  default_scope order("committed_at DESC").scoped(:include => :entries)
  
  def self.populate_commits_newer_than(some_commit_sha, project) 
    API::Commits.each_new_until_existing(project.user.access_token, project.owner_username, project.name, some_commit_sha) do |commit|
      self.create_from_github_commit(commit)
    end
  end     
  
  def self.populate_100_last_commits(project, start_at_sha = nil)
    commits = API::Commits.new(project.user.access_token, project.owner_username, project.name)
    options = { :page => 1, :per_page => 100 }
    options[:sha] = start_at_sha unless start_at_sha.blank?
    commits.load(options).each do |commit|
      self.create_from_github_commit(commit)
    end          
  end

  def invoiced?
    !entries.empty?
  end
  
  def authored_by?(some_user)
    author_username == some_user.username
  end

  def estimated_minutes
    @estimated_minutes ||= estimated_minutes_from_message || estimated_minutes_from_parent_commit
  end
  
  def message
    self[:message] || "" # Never return nil or explosions might happen when estimating time.
  end
  
  def message_without_time_tags
    message.gsub(/#{INITIAL_TAG}.*#{FINAL_TAG}/, "")
  end
  
  def github_url
    repo_url = project.html_url
    repo_url = repo_url + "/" unless repo_url.last == "/"
    repo_url + "commit/#{sha}"
  end
  
  def self.create_from_github_commit(github_commit)
    puts github_commit.inspect

    begin
      self.create do |commit|
        commit.committed_at      = github_commit["commit"]["author"]["date"]
        commit.message           = github_commit["commit"]["message"]
        commit.parents           = github_commit["parents"].collect { |p| p["sha"] }
        commit.sha               = github_commit["sha"]
        commit.author_username   = github_commit["author"]["login"] if github_commit["author"]
        commit.author_avatar_url = github_commit["author"]["avatar_url"] if github_commit["author"]
      end
    rescue Exception => e
      logger.error{"\n\n\n[Error Log] *** Cannot create commit ***"}
      logger.error{"[Error Log] Commit SHA: #{github_commit["sha"]}"}
      logger.error{"[Error Log] Error message: #{e.message}"}
      logger.error{"[Error Log] *** End of log ***\n\n"}
    end

  end
  
  protected
  
  NUMBER = /[0-9]+/
  HOURS_DESCRIPTOR = /\s*(h|hour|hours)\s*/i
  MINUTES_DESCRIPTOR = /\s*(m|min|minute|minutes)\s*/i
  SEPARATOR = /(:|and|&)/i
  INITIAL_TAG = /\[\s*t\s*:\s*/i
  FINAL_TAG = /\s*\]/i
  HOURS_AND_MINUTES_WITH_SEPARATOR = /#{INITIAL_TAG}(#{NUMBER})#{HOURS_DESCRIPTOR}?\s*#{SEPARATOR}\s*(#{NUMBER})#{MINUTES_DESCRIPTOR}?#{FINAL_TAG}/
  HOURS_AND_MINUTES_WITHOUT_SEPARATOR = /#{INITIAL_TAG}(#{NUMBER})#{HOURS_DESCRIPTOR}\s*(#{NUMBER})#{MINUTES_DESCRIPTOR}?#{FINAL_TAG}/
  ONLY_HOURS = /#{INITIAL_TAG}(#{NUMBER})#{HOURS_DESCRIPTOR}#{FINAL_TAG}/
  ONLY_MINUTES = /#{INITIAL_TAG}(#{NUMBER})#{MINUTES_DESCRIPTOR}#{FINAL_TAG}/
  SINGLE_AMBIGUOUS_NUMBER = /#{INITIAL_TAG}(#{NUMBER})#{FINAL_TAG}/
  
  def estimated_minutes_from_message        
    if match = self.message.match(HOURS_AND_MINUTES_WITH_SEPARATOR) || self.message.match(HOURS_AND_MINUTES_WITHOUT_SEPARATOR)
      hours, minutes = extract_numbers_from_captures(match)
      hours * 60 + minutes
    elsif match = self.message.match(ONLY_HOURS)
      extract_numbers_from_captures(match).first * 60
    elsif match = self.message.match(ONLY_MINUTES)
      extract_numbers_from_captures(match).first
    elsif match = self.message.match(SINGLE_AMBIGUOUS_NUMBER)
      number = extract_numbers_from_captures(match).first
      number < 5 ? number * 60 : number
    end
  end
  
  def estimated_minutes_from_parent_commit
    answer = nil
    (parents || []).each do |parent|
      if c = project.commits.find_by_sha(parent)
        answer ||= 0
        answer = [answer, (c.committed_at - self.committed_at).abs / 60].max.round
      end
    end
    answer && 0 < answer && answer < 120 ? answer : nil
  end
  
  private
   
  def extract_numbers_from_captures(match_data)
      match_data.captures.select { |s| s =~ NUMBER }.collect { |s| s.to_i }
  end
end
