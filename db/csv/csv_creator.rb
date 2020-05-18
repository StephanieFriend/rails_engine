class CsvCreator
  def create(csv_hash)
    customer(csv_hash)
    merchant(csv_hash)
    item(csv_hash)
    invoice(csv_hash)
    invoice_item(csv_hash)
    transaction(csv_hash)
  end

  def destroy
    Customer.destroy_all
    Merchant.destroy_all
    Item.destroy_all
    Invoice.destroy_all
    InvoiceItem.destroy_all
    Transaction.destroy_all
  end

  private

  def customer(csv_hash)
    csv_hash[:customers].each { |row| Customer.create(row.to_h) }
  end

  def merchant(csv_hash)
    csv_hash[:merchants].each { |row| Merchant.create(row.to_h) }
  end

  def item(csv_hash)
    csv_hash[:items].each do |row|
      formatted_hash = price_formatting(row)
      Item.create(formatted_hash)
    end
  end

  def invoice(csv_hash)
    csv_hash[:invoices].each { |row| Invoice.create(row.to_h) }
  end

  def invoice_item(csv_hash)
    csv_hash[:invoice_items].each do |row|
      formatted_hash = price_formatting(row)
      InvoiceItem.create(formatted_hash)
    end
  end

  def transaction(csv_hash)
    csv_hash[:transactions].each { |row| Transaction.create(row.to_h) }
  end

  def price_formatting(row)
    new_formatted_hash = row.to_h
    new_formatted_hash[:unit_price] = transform_to_dollars(new_formatted_hash[:unit_price])
    new_formatted_hash
  end

  def transform_to_dollars(cents)
    (cents.to_i / 100.0).round(2)
  end
end