class ChangeQuantityLimitInInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    change_column :invoice_items, :quantity, :integer, limit: 8
  end
end
