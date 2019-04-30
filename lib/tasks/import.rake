require 'csv'

namespace :csv_import do
  desc "import data from customers file"
  task customers: :environment do
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create(row.to_h)
    end
  end
  desc "import data from invoice_items file"
  task invoice_items: :environment do
    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create(row.to_h)
    end
  end
  desc "import data from invoices file"
  task invoices: :environment do
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      Invoice.create(row.to_h)
    end
  end
  desc "import data from items file"
  task items: :environment do
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      Item.create(row.to_h)
    end
  end
  desc "import data from merchants file"
  task merchants: :environment do
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end
  end
  desc "import data from transactions file"
  task transactions: :environment do
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      Transaction.create(row.to_h)
    end
  end

  task :all => [:customers, :invoice_items, :invoices, :items, :merchants, :transactions]
end

desc "Import all csv files"
task import_all: 'csv_import:all'
