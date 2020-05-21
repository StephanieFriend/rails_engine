require 'rails_helper'

describe 'Searching for a single record' do
  it "finds a merchant with matching name attributes" do
    create(:merchant, name: "Harry Potter")
    create(:merchant, name: "Lilly Potter")
    create(:merchant, name: "Hermione Granger")

    get '/api/v1/merchants/find?name=potter'

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes][:name].downcase).to include("potter")
  end
end