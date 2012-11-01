class AddMissedIndexes < ActiveRecord::Migration
  def self.up
    add_index :commits, :project_id
    add_index :commits, :sha
    add_index :projects, :user_id
  end

  def self.down
    remove_index :projects, :user_id
    remove_index :commits, :sha
    remove_index :commits, :project_id
  end
end