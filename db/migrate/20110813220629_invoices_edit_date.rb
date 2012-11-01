class InvoicesEditDate < ActiveRecord::Migration
  def self.up
    change_column :invoices, :date, :string
  end

  def self.down
    change_column :invoices, :date, :date
  end
end