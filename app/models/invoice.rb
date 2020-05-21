class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  def self.total_revenue(start_date, end_date)
    joins(:invoice_items, :transactions).where(transactions: {result: :success})
        .where(created_at: Date.parse(start_date).beginning_of_day...Date.parse(end_date).end_of_day)
        .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end