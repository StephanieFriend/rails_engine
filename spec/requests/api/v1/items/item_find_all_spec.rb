require 'rails_helper'

describe 'Searching for multiple records' do
  scenario 'it can return all items that match the criteria' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)
    create_list(:item, 2, merchant_id: merchant.id, unit_price: 39.50)

    get '/api/v1/items/find_all?name=potter'

    resp = JSON.parse(response.body, symbolize_names: true)

    expect(resp[:data].size).to eq(5)

    get '/api/v1/items/find_all?name=dog&unit_price=39.50'

    resp = JSON.parse(response.body, symbolize_names: true)

    expect(resp[:data].size).to eq(2)
  end
end