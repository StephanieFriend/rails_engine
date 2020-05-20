class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  scope :by_name, ->(name) { where('lower(name) LIKE ?', "%#{name.downcase}%")}
  scope :by_created_at, ->(created_at) { where created_at: created_at }
  scope :by_updated_at, ->(updated_at) { where updated_at: updated_at }

  def self.find_most_revenue(quantity)
    joins(:invoice_items, :transactions).where(transactions: {result: :success}).group(:id)
        .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
        .order("revenue DESC").limit(quantity)
  end

  def self.find_most_items(quantity)
    joins(:invoice_items, :transactions).where(transactions: {result: :success}).group(:id)
        .select("merchants.*, sum(invoice_items.quantity) as sum")
        .order("sum DESC").limit(quantity)
  end

  def find_total_revenue(id)
    Merchant.joins(:invoice_items, :transactions).where(transactions: {result: :success})
        .where(merchants: {id: id}).group(:id)
        .select("merchants.id, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
  end
end