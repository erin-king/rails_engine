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
  describe 'Customer Finders' do
    it 'returns one customer by find parameters' do
      c1 = create(:customer)
      c2 = create(:customer)

      get "/api/v1/customers/find?first_name=#{c1.first_name}"

      expect(response).to be_successful
      customers = JSON.parse(response.body)
      customer = customers["data"]

      expect(customer["attributes"]["first_name"]).to eq(c1.first_name)
      expect(customer["attributes"]["first_name"]).to_not eq(c2.first_name)
    end

    it 'returns and array of customers by find_all parameters' do
      c1 = create(:customer, first_name: "Ben")
      c2 = create(:customer, first_name: "Jazzy")
      c3 = create(:customer, first_name: "Ben")

      get "/api/v1/customers/find_all?first_name=Ben"

      expect(response).to be_successful
      customers = JSON.parse(response.body)
      customer = customers["data"]

      expect(customer[0]["attributes"]["first_name"]).to eq(c1.first_name)
      expect(customer[1]["attributes"]["first_name"]).to eq(c3.first_name)
      expect(customer[2]).to eq(nil)
    end
  end
end
