class Transaction

attr_reader :id, :amount, :category_id, :merchant_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @amount = options['amount'].to_i
  @category_id = options['category_id'].to_i
  @merchant_id = options['merchant_id'].to_i
end

def save()
  sql = "INSERT INTO transactions
        (
          amount,
          category_id,
          merchant_id
        )
        VALUES
        (
          $1, $2, $3
        )
        RETURNING *;"
  values = [@amount, @category_id, @merchant_id]
  results = SqlRunner.run( sql, values )
  @id = results.first['id'].to_i
end

def category()
  sql = "SELECT * FROM categories
        WHERE id = $1;"
  values = [@category_id]
  category = SqlRunner.run( sql, values ).first()
  return Category.new(category)
end

def merchant()
  sql = "SELECT * FROM merchants
        WHERE id = $1;"
  values = [@merchant_id]
  merchant = SqlRunner.run( sql, values ).first()
  return Merchant.new(merchant)
end

def self.all()
  sql = "SELECT * FROM transactions;"
  transactions = SqlRunner.run ( sql )
  return transactions.map { |transaction| Transaction.new( transaction ) }
end

def self.delete_all()
  sql = "DELETE FROM transactions;"
  SqlRunner.run( sql )
end

end
