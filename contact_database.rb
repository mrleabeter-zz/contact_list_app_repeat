## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase

  def self.add_to_database(contact_array)
    CSV.open("contacts.csv", "a") do |csv|
      csv << contact_array
    end
  end

  def self.total_contacts
    CSV.open("contacts.csv", "r") do |csv|
      csv.readlines.size
    end
  end

  def self.list_all_contacts
    CSV.foreach("contacts.csv") do |csv|
      puts "#{csv[0]}:  #{csv[1]} #{csv[2]} (#{csv[3]})"
    end
  end

end