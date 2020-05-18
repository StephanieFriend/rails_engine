require 'rails_helper'

describe 'Sifting through Merchants & Items' do
  it 'can get merchant for an item' do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant_id: merchant1.id)

    get "/api/v1/items/#{item1.id}/merchant"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]

    expect(items[:type]).to eq('merchant')
    expect(items[:id]).to eq(merchant1.id.to_s)
  end

  it 'can get items for a merchant' do
    merchant1 = create(:merchant)
    items = create_list(:item, 5, merchant_id: merchant1.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)
    merchants = json[:data]

    single_merchant = merchants.map do |info, _|
      info[:attributes][:merchant_id]
    end

    expect(Item.count).to eq(5)
    expect(single_merchant.first).to eq(merchant1.id)
  end
end