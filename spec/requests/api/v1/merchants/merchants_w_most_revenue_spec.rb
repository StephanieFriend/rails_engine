require 'rails_helper'

describe "Merchants API" do
  it "returns merchants ranked by total revenue" do
    customer_1 = Customer.create(first_name: "Albus", last_name: "Dumbledore")

    merchant_1 = create(:merchant, name: "Fred Weasley")
    merchant_2 = create(:merchant, name: "Hermione Granger")
    merchant_3 = create(:merchant, name: "Winky")
    merchant_4 = create(:merchant, name: "Severus Snape")

    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)
    item_3 = create(:item, merchant: merchant_3)
    item_4 = create(:item, merchant: merchant_4)

    invoice_1 = Invoice.create(merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = Invoice.create(merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_3 = Invoice.create(merchant_id: merchant_2.id, customer_id: customer_1.id)
    invoice_4 = Invoice.create(merchant_id: merchant_2.id, customer_id: customer_1.id)
    invoice_5 = Invoice.create(merchant_id: merchant_3.id, customer_id: customer_1.id)
    invoice_6 = Invoice.create(merchant_id: merchant_4.id, customer_id: customer_1.id)

    invoice_item_1 = invoice_1.invoice_items.create(item_id: item_1.id, quantity: 9, unit_price: 25.50)
    invoice_item_2 = invoice_1.invoice_items.create(item_id: item_1.id, quantity: 1, unit_price: 63.00)
    invoice_item_3 = invoice_2.invoice_items.create(item_id: item_1.id, quantity: 12, unit_price: 10.03)
    invoice_item_4 = invoice_3.invoice_items.create(item_id: item_2.id, quantity: 4, unit_price: 15.75)
    invoice_item_5 = invoice_3.invoice_items.create(item_id: item_2.id, quantity: 13, unit_price: 100.01)
    invoice_item_6 = invoice_4.invoice_items.create(item_id: item_2.id, quantity: 8, unit_price: 21.12)
    invoice_item_7 = invoice_5.invoice_items.create(item_id: item_3.id, quantity: 10, unit_price: 1.99)
    invoice_item_8 = invoice_6.invoice_items.create(item_id: item_4.id, quantity: 2, unit_price: 9.66)
    invoice_item_9 = invoice_6.invoice_items.create(item_id: item_4.id, quantity: 7, unit_price: 11.05)

    transaction_1 = invoice_1.transactions.create(result: "success")
    transaction_2 = invoice_2.transactions.create(result: "success")
    transaction_3 = invoice_3.transactions.create(result: "success")
    transaction_4 = invoice_4.transactions.create(result: "success")
    transaction_5 = invoice_5.transactions.create(result: "success")
    transaction_6 = invoice_6.transactions.create(result: "success")

    get '/api/v1/merchants/most_revenue?quantity=3'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
    first_merchant = merchants[:data].first
    last_merchant = merchants[:data].last

    expect(merchants[:data].count).to eq(3)
    expect(first_merchant[:attributes][:name]).to eq("Hermione Granger")
    expect(last_merchant[:attributes][:name]).to eq("Severus Snape")
  end
end