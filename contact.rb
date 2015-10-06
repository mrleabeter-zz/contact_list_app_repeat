require 'pry'

class Contact
 
  attr_accessor :first_name, :last_name, :email, :id, :phone_numbers

  def initialize(first_name, last_name, email, id = nil, phone_numbers = nil)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @id = id
    @phone_numbers = phone_numbers
  end
 

  ## Class Methods
  class << self

    def connection
      PG.connect(
      host: 'localhost',
      dbname: 'contact_list'
    )
    end

    def array_to_contact(contact_array)
      Contact.new(contact_array[1], contact_array[2], contact_array[3], contact_array[0], contact_array[4])
    end

    def total_contacts
      ContactDatabase.read_contact_database.length
    end

    def create(first_name, last_name, email, phone_numbers)
      id = total_contacts + 1
      contact_array = [id, first_name, last_name, email, phone_numbers]
      ContactDatabase.add_to_database(contact_array)
      array_to_contact(contact_array)
    end
 
    def all
      array_of_contacts = ContactDatabase.read_contact_database
      array_of_contacts.map do |contact|
        array_to_contact(contact)
      end
    end

    def show(id)
      array_of_contacts = ContactDatabase.read_contact_database
      array_of_contacts.each do |contact|
        if contact.include?(id)
          return array_to_contact(contact)
        end
      end
      nil
    end
    
    def find(term)
      search_results = []
      array_of_contacts = ContactDatabase.read_contact_database
      array_of_contacts.select do |contact|
        contact.each do |item|
          if item.include?(term)
            search_results << array_to_contact(contact)
          end
        end
      end
      search_results
    end

  end
 
end