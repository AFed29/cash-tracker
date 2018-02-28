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

  def update()
    sql = "UPDATE merchants
           SET name = $1
           WHERE id =$2;"
    values = [@name, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM merchants
           WHERE id = $1;"
    values = [@id]
    SqlRunner.run( sql, values )
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

  def self.find_by_id( id )
    sql = "SELECT * FROM merchants
           WHERE id = $1;"
    values = [id]
    merchant_hash = SqlRunner.run( sql, values ).first()
    return Merchant.new( merchant_hash )
  end

  def self.check_if_name_exists( name )
    sql = "SELECT * FROM merchants
           WHERE name = $1;"
    values = [name]
    merchants_hash = SqlRunner.run( sql, values )
    merchants = merchants_hash.map { |merchant| Merchant.new(merchant) }
    return true if merchants.count !=0
    return false
  end

  def self.check_if_exists_in_transaction( id )
    sql = "SELECT * FROM merchants
           WHERE id = $1
           AND
           EXISTS
          (
            SELECT 1 FROM transactions
            WHERE merchant_id = $1 LIMIT 1
          );"
    values = [id]
    merchants_hash = SqlRunner.run( sql, values )
    merchants = merchants_hash.map { |merchant| Merchant.new( merchant ) }
    return true if merchants.count != 0
    return false
  end

end
