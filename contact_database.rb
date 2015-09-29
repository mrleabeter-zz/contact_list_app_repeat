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
    CSV.foreach("contacts.csv") do |csv_line|
      puts "#{csv_line[0]}:  #{csv_line[1]} #{csv_line[2]} (#{csv_line[3]})"
    end
  end

  def self.contact_by_id(id)
    contact = nil
    CSV.foreach("contacts.csv") do |csv_line|
      if csv_line[0] == id
        contact = csv_line
      end
    end
    if contact != nil
      puts "First Name: #{contact[1]}"
      puts "Last Name: #{contact[2]}"
      puts "Email: #{contact[3]}"
    else
        puts "Not found: I'm sorry, but I don't have a record for contact ID ##{id}"
    end
  end

  def self.search_contact(term)
    
  end

end