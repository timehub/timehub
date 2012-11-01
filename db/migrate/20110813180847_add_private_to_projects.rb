class AddPrivateToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :private, :boolean
  end

  def self.down
    remove_column :projects, :private
  end
end
