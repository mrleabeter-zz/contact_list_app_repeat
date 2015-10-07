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
      sql = 'UPDATE contacts SET firstname=$1, lastname=$2, email=$3 WHERE id =$4;'
      self.class.connection.exec_params(sql, [self.first_name, self.last_name, self.email, @id])
    else
      sql = 'INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3) RETURNING id;'
      result = self.class.connection.exec_params(sql, [self.first_name, self.last_name, self.email])
      @id = result[0]["id"].to_i
    end
  end
 

  ## Class Methods
  class << self

    @@db_connection = nil

    def connection
      return @@db_connection unless @@db_connection.nil?
      @@db_connection = PG.connect(
        host: 'localhost',
        dbname: 'contact_list',
        user: 'christopher',
        password: 'MyPassw0rd4768p')
    end

    def all
      self.connection.exec('SELECT * FROM contacts;') do |results|
        results.map do |hash|
          Contact.new(hash)
        end
      end
    end

    def show(id)
      result = self.connection.exec_params('SELECT * FROM contacts WHERE id=$1;', [id])
      if result[0]
        Contact.new(result[0])
      end
    end

    def find(term)
      term = "%#{term}%"
      self.connection.exec_params('SELECT * FROM contacts WHERE firstname LIKE $1 OR lastname LIKE $1 OR email LIKE $1;', [term]) do |results|
        results.map do |hash|
          Contact.new(hash)
        end
      end
    end

  end
 
end