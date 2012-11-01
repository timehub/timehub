class TimeEntriesRemoveSha < ActiveRecord::Migration
  def self.up
    remove_column :time_entries, :commit_sha
    remove_column :time_entries, :project_id
    add_column :time_entries, :commit_id, :integer
    add_index :time_entries, :commit_id
  end

  def self.down
    remove_index :time_entries, :commit_id
    remove_column :time_entries, :commit_id
    add_column :time_entries, :project_id, :integer
    add_column :time_entries, :commit_sha, :string
  end
end
