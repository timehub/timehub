class AddRateToInvoice < ActiveRecord::Migration
  def self.up
    add_column :invoices, :rate, :float, :default => 0.0
  end

  def self.down
    remove_column :invoices, :rate
  end
end
