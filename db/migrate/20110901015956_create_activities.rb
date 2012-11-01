class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :minutes
      t.text :description
      t.integer :project_id

      t.timestamps
    end
    
    add_index :activities, :project_id
  end
end