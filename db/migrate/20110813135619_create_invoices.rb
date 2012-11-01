class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.integer :user_id
      t.timestamps
    end

    add_index :invoices, :user_id
  end

  def self.down
    remove_index :invoice, :user_id
    drop_table :invoices
  end
end