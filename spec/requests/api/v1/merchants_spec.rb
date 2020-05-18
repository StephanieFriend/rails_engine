require 'rails_helper'

describe "Merchants API" do
  it 'can get all merchants' do
    merchant_list = create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants['data'].count).to eq(3)
    expect(merchants['data'].first['id']).to eq(merchant_list.first.id.to_s)
  end

  it 'can get a merchant' do
    merchant_list = create_list(:merchant, 3)
    merchant_id = merchant_list.last.id
    get "/api/v1/merchants/#{merchant_id}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants['data']['id']).to eq(merchant_id.to_s)
    expect(merchants['data']['type']).to eq("merchant")
  end

  it 'can create new merchants' do
    create(:merchant)
    create(:merchant)

    expect(Merchant.count).to eq(2)

    new_merchant = { name: 'Newt Scamander' }

    post "/api/v1/merchants", params: new_merchant

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(Merchant.count).to eq(3)
    expect(json['data']['attributes']['name']).to eq('Newt Scamander')
  end

  it "can update an existing merchant" do
    merchant = create(:merchant)
    previous_id = merchant.id
    previous_name = merchant.name
    merchant_params = { name: 'Newt Scamander' }

    put "/api/v1/merchants/#{previous_id}", params: merchant_params

    expect(response).to be_successful

    json = JSON.parse(response.body)

    expect(json['data']['attributes']['name']).to_not eq(previous_name)
    expect(json['data']['attributes']['name']).to eq("Newt Scamander")
  end

  it "can destroy a merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
