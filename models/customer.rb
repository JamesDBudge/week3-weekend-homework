require_relative('./film.rb')
require_relative('../db/sql_runner')
require_relative('./ticket.rb')


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @name = options['name']
    @funds = options['funds']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    self.map_items(customers)
  end

  def self.map_items(customer_data)
    results = customer_data.map { |customer| Customer.new(customer)  }
    return results
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def film_by_customer
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return Film.map_items(films)
  end

  def list_of_viewings
    sql = "SELECT tickets.*, films.* FROM tickets
    INNER JOIN films
    ON tickets.film_id = films.id
    WHERE customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return Film.map_items(films)
  end

  def spend_funds
    films = self.list_of_viewings
    ticket_costs = films.map { |ticket| ticket.price.to_i }
    total_cost = ticket_costs.sum
    @funds -= total_cost
  end

  def number_of_tickets
    return self.list_of_viewings.length

  end


end
