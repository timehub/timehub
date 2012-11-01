class ProjectsAddRate < ActiveRecord::Migration
  def self.up
    add_column :projects, :rate, :float
  end

  def self.down
    remove_column :projects, :rate
  end
end