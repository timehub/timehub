class EntriesRenameTime < ActiveRecord::Migration
  def self.up
    rename_column :time_entries, :time, :minutes
  end

  def self.down
    rename_column :time_entries, :minutes, :time
  end
end