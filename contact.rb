class Contact
 
  attr_accessor :first_name, :last_name, :email, :id

  def initialize(first_name, last_name, email, id = nil )
    @first_name = first_name
    @last_name = last_name
    @email = email
    @id = id
  end
 

  ## Class Methods
  class << self

    def array_to_contact(contact_array)
      Contact.new(contact_array[1], contact_array[2], contact_array[3], contact_array[0])
    end

    def create(first_name, last_name, email)
      id = ContactDatabase.read_contact_database.length + 1
      contact_array = [id, first_name, last_name, email]
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
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
      # use array.select
    end 
    
  end
 
end