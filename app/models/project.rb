class Project < ActiveRecord::Base
  validates_presence_of :name, :html_url, :api_url, :owner_username, :user_id
  validates_uniqueness_of :name, :scope => [ :user_id ]
  validates_numericality_of :rate, :greater_than => 1, :allow_blank => true

  belongs_to :user
  has_many :invoices, :dependent => :destroy
  has_many :commits, :dependent => :destroy
  has_many :activities, :dependent => :destroy

  paginates_per 50

  make_permalink :name

  def to_param
    permalink
  end

  def to_s
    display_name
  end

  def display_name
    "#{owner_username}/#{name}"
  end

  def visibility
    private? ? "private" : "public"
  end

  def total_invoiced
    invoices.map(&:total).sum
  end

  def self.create_from_github_repo(repo)
    puts repo.inspect
    self.create do |project|
      project.description      = repo["description"]
      project.name             = repo["name"]
      project.private          = repo["private"]
      project.api_url          = repo["url"]
      project.html_url         = repo["html_url"]
      project.owner_username   = repo["owner"]["login"]
      project.owner_avatar_url = repo["owner"]["avatar_url"]
    end
  end
end
