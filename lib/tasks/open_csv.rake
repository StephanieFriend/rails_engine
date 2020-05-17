require './db/csv/sales_engine.rb'
require './db/csv/csv_creator.rb'

namespace :db do
  namespace :seed do
    desc "Seeds the db from remote CSV files"
    task :from_csv => :environment do
      CsvCreator.destroy
      csv_hash = SalesEngine.csv_info
      CsvCreator.create(csv_hash)
    end
  end
end