require_relative 'contact'
require_relative 'contact_database'
require 'pry'

class Application

  def command_list
    case ARGV[0]

    when "help"
      puts "Here is a list of available commands:"
      puts "new - Create a new contact"
      puts "list - List all contacts"
      puts "show - Show a contact"
      puts "find - Find a contact"

    when "new"
      puts "You selected create a new contact."
      puts "Please enter the email address of the contact you would like to create."
      email = STDIN.gets.chomp
      email_check = Contact.find(email)
      if email_check != []
        puts "A contact with the email address #{email} already exists, and can not be duplicated.\nThe contact information is displayed below:"
        email_check.each do |contact|
          puts "#{contact.id}:  #{contact.first_name} #{contact.last_name} (#{contact.email})"
          exit
        end
      end
      puts "Please enter the first name of the contact you would like to create."
      first_name = STDIN.gets.chomp.capitalize
      puts "Please enter the last name of the contact you would like to create."
      last_name = STDIN.gets.chomp.capitalize
      phone_number_input = ""
      phone_numbers = {}
      while phone_number_input != "done" do
        puts "Please enter a label & phone number using the following format: label, XXX XXX XXXX.\nEnter done when you have no more phone numbers to enter."
        phone_number_input = STDIN.gets.chomp
        if phone_number_input != "done"
          label, number = phone_number_input.split(", ")
          phone_numbers[label] = number
        end
      end
      contact = Contact.create(first_name, last_name, email, phone_numbers)
      puts "The contact #{first_name} #{last_name} has been stored under ID ##{contact.id}"

    when "list"
      puts "You selected list all contacts.\nHere is a list of all your contacts:"
      Contact.all.each do |contact|
        puts "#{contact.id}:  #{contact.first_name} #{contact.last_name} (#{contact.email}) #{contact.phone_numbers}"
      end
      puts "---"
      puts "#{Contact.total_contacts} total contacts"

    when "show"
      puts "You selected show a contact.\nPlease enter the ID # of the contact you would like to display."
      contact_id = STDIN.gets.chomp
      contact = Contact.show(contact_id)
      if contact != nil
        puts "Here is the contact that matches ID ##{contact.id}:"
        puts "First Name: #{contact.first_name}"
        puts "Last Name: #{contact.last_name}"
        puts "Email: #{contact.email}"
        puts "Phone Numbers: #{contact.phone_numbers}"
      else
          puts "Not found: I'm sorry, but there is no record for contact ID ##{contact_id}"
      end

    when "find"
      puts "You selected find a contact.\nPlease enter a term to search for within the contact list - remember, this search is case sensitive."
      search_term = STDIN.gets.chomp
      contacts = Contact.find(search_term)
      if contacts != []
        puts "Here are the contacts that match the search term '#{search_term}':"
        contacts.each do |contact|
          puts "#{contact.id}:  #{contact.first_name} #{contact.last_name} (#{contact.email})"
        end
      else
        puts "Not found: I'm sorry, but there are no contacts which contain your search term."
      end
    else
      puts "I'm sorry, I don't recognize that command."
    end

  end
  
end

test = Application.new
test.command_list