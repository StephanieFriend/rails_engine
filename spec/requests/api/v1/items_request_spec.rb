require 'rails_helper'

describe "Items API" do
  it 'can get all items' do
    merchant = create(:merchant)
    item_list = create_list(:item, 3, merchant_id: merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(3)
    expect(items['data'].first['id']).to eq(item_list.first.id.to_s)
  end

  it 'can get an item' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)
    item_id = merchant.items.last.id
    get "/api/v1/items/#{item_id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data']['id']).to eq(item_id.to_s)
    expect(items['data']['type']).to eq("item")
  end

  it 'can create new items' do
    merchant = create(:merchant)
    create(:item, merchant_id: merchant.id)
    create(:item, merchant_id: merchant.id)

    expect(Item.count).to eq(2)

    new_item = { name: 'Fantastic Beasts And Where To Find Them',
             description: 'New York is considerably more interesting than I expected.',
             unit_price: 39.99,
             merchant_id: merchant.id
    }

    post "/api/v1/items", params: new_item

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(Item.count).to eq(3)
    expect(json['data']['attributes']['name']).to eq('Fantastic Beasts And Where To Find Them')
  end

  it "can update an existing item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    previous_id = item.id
    previous_name = item.name
    item_params = { name: "Harry Potter And The Cursed Child",
                    description: "My geekness is a-quivering",
                    unit_price: 8.00 }

    put "/api/v1/items/#{previous_id}", params: item_params

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data']['attributes']['name']).to_not eq(previous_name)
    expect(json['data']['attributes']['name']).to eq("Harry Potter And The Cursed Child")
  end

  it "can destroy an item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end