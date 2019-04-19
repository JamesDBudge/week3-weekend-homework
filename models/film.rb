require_relative('./customer.rb')
require_relative('../db/sql_runner')
require_relative('./ticket.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @title = options['title']
    @price = options['price']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    self.map_items(films)
  end

  def self.map_items(film_data)
    results = film_data.map { |film| Film.new(film)  }
    return results
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customer_by_film
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return Customer.map_items(customers)
  end

  def number_of_customers_going_to_film
    return customer_by_film.length
  end



end
