class AddInvoicesFields < ActiveRecord::Migration
  def self.up
    add_column :invoices, :recipient, :string
    add_column :invoices, :creator_name, :string
    add_column :invoices, :creator_details, :string
    add_column :invoices, :date, :date
    add_column :invoices, :reference_id, :string
  end

  def self.down
    remove_column :invoices, :reference_id
    remove_column :invoices, :date
    remove_column :invoices, :creator_details
    remove_column :invoices, :creator_name
    remove_column :invoices, :recipient
  end
end