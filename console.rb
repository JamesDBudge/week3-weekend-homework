require('pry-byebug')

require_relative('models/film.rb')
require_relative('models/customer.rb')
require_relative('models/ticket.rb')



Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({'name' => 'James Swatton', 'funds' => 50})
customer2 = Customer.new({'name' => 'James Walker', 'funds' => 40})
customer3 = Customer.new({'name' => 'James Budge', 'funds' => 30})

customer1.save()
customer2.save()
customer3.save()

film1 = Film.new({'title' => 'Avengers: Endgame', 'price' => 9})
film2 = Film.new({'title' => 'Alita: Battle Angel', 'price' => 7})
film3 = Film.new({'title' => 'Captain Marvel', 'price' => 6})

film1.save()
film2.save()
film3.save()

ticket01 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket02 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket03 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket04 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket05 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id})
ticket06 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket07 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket08 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket09 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket10 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})

ticket01.save()
ticket02.save()
ticket03.save()
ticket04.save()
ticket05.save()
ticket06.save()
ticket07.save()
ticket08.save()
ticket09.save()
ticket10.save()

binding.pry
nil
