require 'rails_helper'

describe 'Searching for a single record' do
  it "finds an item with a matching attribute" do
    merchant = create(:merchant)
    book_1 = create(:item, name: "Harry Potter And The Cursed Child",
                    description: "My geekness is a-quivering",
                    unit_price: 8.00, merchant_id: merchant.id )
    book_2 = create(:item, name: "Fantastic Beasts And Where To Find Them",
                    description: "New York is considerably more interesting than I expected.",
                    unit_price: 50.68, merchant_id: merchant.id )
    book_3 = create(:item, name: "Harry Potter and The Chamber Of Secrets",
                    description: "Honestly, if you were any slower, you’d be going backward",
                    unit_price: 21.45, merchant_id: merchant.id )
    book_4 = create(:item, name: "Harry Potter and The Half Blood Prince",
                    description: "You sort of start thinking anything’s possible if you’ve got enough nerve",
                    unit_price: 49.99, merchant_id: merchant.id)

    get '/api/v1/items/find?name=fantastic'
    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes][:name].downcase).to include("fantastic")
  end

  it "finds an item with matching description" do
    merchant = create(:merchant)
    book_1 = create(:item, name: "Harry Potter And The Cursed Child",
                    description: "My geekness is a-quivering",
                    unit_price: 8.00, merchant_id: merchant.id )
    book_2 = create(:item, name: "Fantastic Beasts And Where To Find Them",
                    description: "New York is considerably more interesting than I expected.",
                    unit_price: 50.68, merchant_id: merchant.id )
    book_3 = create(:item, name: "Harry Potter and The Chamber Of Secrets",
                    description: "Honestly, if you were any slower, you’d be going backward",
                    unit_price: 21.45, merchant_id: merchant.id )
    book_4 = create(:item, name: "Harry Potter and The Half Blood Prince",
                    description: "You sort of start thinking anything’s possible if you’ve got enough nerve",
                    unit_price: 49.99, merchant_id: merchant.id)

    get '/api/v1/items/find?description=honestly'
    json = JSON.parse(response.body, symbolize_names: true)
    item = json[:data][:attributes]

    expect(item[:name]).to eq("Harry Potter and The Chamber Of Secrets")
    expect(item[:description]).to eq("Honestly, if you were any slower, you’d be going backward")
  end

  it "finds an item with matching merchant id" do
    merchant = create(:merchant)
    id = merchant.id
    book_1 = create(:item, name: "Harry Potter And The Cursed Child",
                    description: "My geekness is a-quivering",
                    unit_price: 8.00, merchant_id: merchant.id )
    book_2 = create(:item, name: "Fantastic Beasts And Where To Find Them",
                    description: "New York is considerably more interesting than I expected.",
                    unit_price: 50.68, merchant_id: merchant.id )
    book_3 = create(:item, name: "Harry Potter and The Chamber Of Secrets",
                    description: "Honestly, if you were any slower, you’d be going backward",
                    unit_price: 21.45, merchant_id: merchant.id )
    book_4 = create(:item, name: "Harry Potter and The Half Blood Prince",
                    description: "You sort of start thinking anything’s possible if you’ve got enough nerve",
                    unit_price: 49.99, merchant_id: merchant.id)

    get "/api/v1/items/find?merchant_id=#{id}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data][:attributes][:merchant_id].to_s).to eq("#{id}")
  end

  it "finds an item matching multiple attributes" do
    merchant = create(:merchant)
    book_1 = create(:item, name: "Harry Potter And The Cursed Child",
                    description: "My geekness is a-quivering",
                    unit_price: 8.00, merchant_id: merchant.id )
    book_2 = create(:item, name: "Fantastic Beasts And Where To Find Them",
                    description: "New York is considerably more interesting than I expected.",
                    unit_price: 50.68, merchant_id: merchant.id )
    book_3 = create(:item, name: "Harry Potter and The Chamber Of Secrets",
                    description: "Honestly, if you were any slower, you’d be going backward",
                    unit_price: 21.45, merchant_id: merchant.id )
    book_4 = create(:item, name: "Harry Potter and The Half Blood Prince",
                    description: "You sort of start thinking anything’s possible if you’ve got enough nerve",
                    unit_price: 49.99, merchant_id: merchant.id)

    get '/api/v1/items/find?name=potter&description=thinking'
    json = JSON.parse(response.body, symbolize_names: true)
    item = json[:data][:attributes]

    expect(item[:name]).to eq("Harry Potter and The Half Blood Prince")
    expect(item[:description]).to eq("You sort of start thinking anything’s possible if you’ve got enough nerve")
  end
end