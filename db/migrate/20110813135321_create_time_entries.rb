class CreateTimeEntries < ActiveRecord::Migration
  def self.up
    create_table :time_entries do |t|
      t.integer :invoice_id
      t.text :description
      t.integer :time
      t.string :commit_sha
      t.integer :project_id

      t.timestamps
    end

    add_index :time_entries, :invoice_id
    add_index :time_entries, :project_id
  end

  def self.down
    remove_index :time_entries, :project_id
    remove_index :time_entries, :invoice_id

    drop_table :time_entries
  end
end