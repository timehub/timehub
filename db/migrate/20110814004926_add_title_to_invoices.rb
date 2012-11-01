class AddTitleToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :title, :string
  end

  def self.down
    remove_column :invoices, :title
  end
end
