class EditInvoicesForeignKeys < ActiveRecord::Migration
  def self.up
    rename_column :invoices, :user_id, :project_id
  end

  def self.down
    rename_column :invoices, :project_id, :user_id
  end
end