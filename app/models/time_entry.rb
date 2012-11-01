class TimeEntry < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :commit

  validates_presence_of :description, :minutes
  validates_presence_of :invoice, :on => :update
  validates_numericality_of :minutes, :only_integer => true, :greater_than => 0

  def formatted_minutes
    return "" if self.minutes.blank?
    hours = self.minutes / 60
    fmin = "%02d" % (self.minutes % 60).to_s
    "#{hours}:#{fmin}"
  end

  def formatted_minutes=(hours)
    hour, min = hours.split(":")
    self.minutes = hour.to_i * 60
    self.minutes += min.to_i
  end
  
  def hours
    (self.minutes / 60.0).round(2)
  end

end
