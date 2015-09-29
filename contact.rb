class Contact
 
  attr_accessor :first_name, :last_name, :email

  def initialize(first_name, last_name, email)
    @first_name = first_name
    @last_name = last_name
    @email = email
  end
 
  def to_s
    # TODO: return string representation of Contact
  end
 

  ## Class Methods
  class << self
    def create(first_name, last_name, email)
      contact_array = []
      id = ContactDatabase.total_contacts
      contact_array << id += 1
      contact_array << first_name
      contact_array << last_name
      contact_array << email
      ContactDatabase.add_to_database(contact_array)
    end
 
    def find(term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
    end
 
    def all
      # TODO: Return the list of contacts, as is
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
    end
    
  end
 
end