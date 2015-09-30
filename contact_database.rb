## TODO: Implement CSV reading/writing
require 'csv'
require 'pry'

class ContactDatabase

  # database create method
  def self.add_to_database(contact_array)
    CSV.open("contacts.csv", "a") do |csv_line|
      csv_line << contact_array
    end
  end

  # database read method
  def self.read_contact_database
    contact = CSV.read("contacts.csv")
  end

end