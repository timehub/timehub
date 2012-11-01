class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :html_url
      t.string :api_url
      t.string :owner_username
      t.string :owner_avatar_url

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
