class Activity < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :description
  validates_numericality_of :minutes, :only_integer => true, :greater_than => 0
end
