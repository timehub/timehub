class CreateCommits < ActiveRecord::Migration
  def self.up
    create_table :commits do |t|
      t.integer :project_id
      t.datetime :commited_at
      t.string :message
      t.string :sha
      t.text :parents
      t.string :author_username
      t.string :author_avatar_url

      t.timestamps
    end
  end

  def self.down
    drop_table :commits
  end
end
