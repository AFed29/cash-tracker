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

def amount_pounds_to_display()
  pounds = @amount/100
  return pounds
end

def amount_pence_to_display()
  pence = @amount - (amount_pounds_to_display * 100)
  result = pence.to_s.rjust(2, "0")
  return result
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
  transactions = SqlRunner.run( sql )
  return transactions.map { |transaction| Transaction.new( transaction ) }
end

def self.delete_all()
  sql = "DELETE FROM transactions;"
  SqlRunner.run( sql )
end

def self.total_spent_display_pounds()
  total = 0
  sql = "SELECT * FROM transactions;"
  transactions_hash = SqlRunner.run( sql )
  transactions = transactions_hash.map { |transaction_hash|
    Transaction.new(transaction_hash) }
  transactions.each { |transaction| total += transaction.amount.to_i }
  total_pounds = total / 100
  return total_pounds
end

def self.total_spent_display_pence()
  total = 0
  sql = "SELECT * FROM transactions;"
  transactions_hash = SqlRunner.run( sql )
  transactions = transactions_hash.map { |transaction_hash|
    Transaction.new(transaction_hash) }
  transactions.each { |transaction| total += transaction.amount.to_i }
  total_pence = total - (total_spent_display_pounds()*100)
  return total_pence.to_s.rjust(2, "0")
end

end
