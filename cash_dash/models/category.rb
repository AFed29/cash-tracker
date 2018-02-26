require_relative('../db/sql_runner.rb')

class Category

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name'].capitalize()
  end

  def save()
    sql = "INSERT INTO categories
          ( name )
          VALUES
          ( $1 )
          RETURNING *;"
    values = [@name]
    results = SqlRunner.run( sql, values )
    @id = results.first['id'].to_i
  end

  def total_amount_spent()
    sql = "SELECT SUM(amount)
          FROM transactions
          WHERE category_id = $1;"
    values = [@id]
    hash = SqlRunner.run( sql, values ).first
    total = hash['sum']
    return total.to_i
  end

  def self.all()
    sql = "SELECT * FROM categories;"
    categories = SqlRunner.run ( sql )
    return categories.map { |category| Category.new( category ) }
  end

  def self.delete_all()
    sql = "DELETE FROM categories;"
    SqlRunner.run( sql )
  end

end
