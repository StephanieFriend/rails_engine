require 'rails_helper'

describe 'Searching for multiple records' do
  scenario 'it can return all merchants that match the criteria' do
    create(:merchant, name: "Harry Potter")
    create(:merchant, name: "Lilly Potter")
    create(:merchant, name: "Hermione Granger")

    get '/api/v1/merchants/find_all?name=potter'

    resp = JSON.parse(response.body, symbolize_names: true)

    expect(resp[:data].size).to eq(2)
  end
end