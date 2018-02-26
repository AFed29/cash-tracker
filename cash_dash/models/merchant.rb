require_relative('../db/sql_runner.rb')

class Merchant

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name'].capitalize()
  end

  def save()
    sql = "INSERT INTO merchants
          ( name )
          VALUES
          ( $1 )
          RETURNING *;"
    values = [@name]
    results = SqlRunner.run( sql, values )
    @id = results.first['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM merchants;"
    merchants = SqlRunner.run ( sql )
    return merchants.map { |merchant| Merchant.new( merchant ) }
  end

  def self.delete_all()
    sql = "DELETE FROM merchants;"
    SqlRunner.run( sql )
  end

end
