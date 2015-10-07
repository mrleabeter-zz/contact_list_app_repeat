require_relative 'contact'

Contact.connection.exec(
  'DROP TABLE contacts;
  CREATE TABLE contacts (
    id serial NOT NULL PRIMARY KEY,
    firstname varchar(40) NOT NULL,
    lastname varchar(40) NOT NULL,
    email varchar(40) NOT NULL
    );'
  )

mike = Contact.new({"firstname" => "Mike", "lastname" => "Easton", "email" => "measton@gmail.com"})
mike.save
mike.save

chris = Contact.new({"firstname" => "Chris", "lastname" => "Leabeter", "email" => "cleabs@gmail.com"})
chris.save
chris.save

sarah = Contact.new({"firstname" => "Sarah", "lastname" => "Leabeter", "email" => "sleabs@gmail.com"})
sarah.save
sarah.save

batman = Contact.new({"firstname" => "Bruce", "lastname" => "Wayne", "email" => "notbatman@wayneenterprises.com"})
batman.save
batman.save
batman.save

# puts Contact.all.inspect

# puts Contact.show(4).inspect

puts Contact.find('ea').inspect