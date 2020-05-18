require 'csv'
require 'open-uri'

class SalesEngine
  class << self
    def csv_info
      @csv_info ||= csv_locations.inject({}) do |new_csv_hash, (file_name, url)|
        csv_text = open(url)
        new_csv_hash[file_name] = CSV.parse(csv_text, headers: true, header_converters: :symbol)
        new_csv_hash
      end
    end

    def csv_locations
      {
        customers: original_location("customers"),
        invoice_items: original_location("invoice_items"),
        invoices: original_location("invoices"),
        items: original_location("items"),
        merchants: original_location("merchants"),
        transactions: original_location("transactions")
      }
    end

    private

    def original_location(file_name)
      "https://raw.githubusercontent.com/turingschool-examples/sales_engine/master/data/#{file_name}.csv"
    end
  end
end