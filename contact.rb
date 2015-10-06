require 'pry'
require 'pg'

class Contact
 
  attr_accessor :first_name, :last_name, :email, :phone_numbers
  attr_reader :id

  def initialize(hash)
    @id = hash["id"].to_i if hash["id"]
    @first_name = hash["firstname"]
    @last_name = hash["lastname"]
    @email = hash["email"]
    @phone_numbers = phone_numbers
  end

  def save
    if id
      sql = 'UPDATE contacts SET firstname=$1, lastname=$2, email=$3 WHERE id =$5;'
      self.class.connection.exec_params(sql, [self.first_name, self.last_name, self.email, @id])
    else
      sql = 'INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3) RETURNING id;'
      result = self.class.connection.exec_params(sql, [self.first_name, self.last_name, self.email])
      id = result[0]["id"].to_i
    end
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