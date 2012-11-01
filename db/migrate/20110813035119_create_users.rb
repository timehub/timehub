class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :username
      t.string   :email
      t.string   :access_token
      t.string   :name
      t.string   :site_url
      t.string   :gravatar_token
      t.boolean  :admin
      t.string   :github_uid
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
