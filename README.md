* Ruby version
  Ruby 2.4.1
  Rails 5.1.7

* Additional Gems
  factory_bot_rails
  pry
  rspec-rails

* System dependencies

* Configuration

* Database creation
rake import_all            #imports all files in db/data
rake csv_import:customers  #imports only the customers file; 'customers' can be changed for any file in name in db/data

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

rails g migration AddIndexToCustomers
add_index :customers, :id, unique: true
