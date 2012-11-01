class RenameCommitedAtToCommittedAtInCommits < ActiveRecord::Migration
  def self.up
    rename_column :commits, :commited_at, :committed_at
  end

  def self.down
    rename_column :commits, :committed_at, :commited_at
  end
end
