require_relative 'contact'

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

puts Contact.all.inspect

puts Contact.show(4).inspect