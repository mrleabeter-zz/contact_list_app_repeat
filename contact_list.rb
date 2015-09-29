require_relative 'contact'
require_relative 'contact_database'

# TODO: Implement command line interaction
# This should be the only file where you use puts and gets

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
      puts "Please enter the first name of the contact you would like to create."
      first_name = STDIN.gets.chomp.capitalize
      puts "Please enter the last name of the contact you would like to create."
      last_name = STDIN.gets.chomp.capitalize
      puts "Please enter the email address of the contact you would like to create."
      email = STDIN.gets.chomp
      Contact.create(first_name, last_name, email)
      puts "The contact #{first_name} #{last_name} with email address #{email} has been stored under ID ##{ContactDatabase.total_contacts}"
    when "list"
      puts "You selected list all contacts.\nHere is a list of all your contacts:"
      Contact.all
    when "show"
      puts "You selected show a contact.\nPlease enter the ID # of the contact you would like to display."
      contact_id = STDIN.gets.chomp
      puts "Here is the contact that matches ID ##{contact_id}:"
      Contact.show(contact_id)
    when "find"
      puts "You selected find a contact.\nPlease enter a term to search for within the contact list."
      search_term = STDIN.gets.chomp.downcase
      puts "Here are the contacts that match your search term."
      Contact.find(search_term)
    else
      puts "I'm sorry, I don't recognize that command."
    end

  end
  
end

test = Application.new
test.command_list