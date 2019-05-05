require 'rails_helper'

RSpec.describe 'Customers API' do
  describe 'Customers endpoints' do
    it 'sends a list of all customers' do
      create_list(:customer, 3)

      get '/api/v1/customers'

      expect(response).to be_successful

      customers = JSON.parse(response.body)
      all_customers = customers["data"]

      all_customers.each do |customer|
        expect(customer).to have_key("id")
        expect(customer).to have_key("type")
        expect(customer).to have_key("attributes")
        expect(customer).to_not have_key("created_at")
      end

      expect(all_customers.count).to eq(3)
    end

    it 'sends one customer by id' do
      id = create(:customer).id

      get "/api/v1/customers/#{id}"

      expect(response).to be_successful

      customer = JSON.parse(response.body)

      expect(customer["data"]["attributes"]["id"]).to eq(id)
    end
  end
end
