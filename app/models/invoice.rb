class Invoice < ActiveRecord::Base
  belongs_to :project

  has_many :entries, :class_name => "TimeEntry", :dependent => :destroy

  accepts_nested_attributes_for :entries, :allow_destroy => true,
  :reject_if => proc { |inv| inv['description'].blank? }

  before_save :set_rate

  def total_hours
    (total_minutes / 60.0).round(2)
  end

  def total
    total_hours * rate.to_f
  end

  def to_s
    name
  end

  def name
    title.presence || "Invoice for #{project.name}"
  end

  def total_minutes
    entries.map(&:minutes).sum
  end

  def formatted_minutes
    minutes = total_minutes
    return "0:00" if minutes.blank? or minutes.zero?
    hours = minutes / 60
    fmin = "%02d" % (minutes % 60).to_s
    "#{hours}:#{fmin}"
  end

  def build_entries_from_commits(commit_ids)
    project.commits.find(commit_ids).each do |commit|
      self.entries.build  commit: commit,
                          description: commit.message_without_time_tags,
                          minutes: commit.estimated_minutes
    end
  end

  ##########################################################################################
  private

  def set_rate
    self.rate ||= project.rate.to_f
  end

end
