require('date')

class Transaction

  attr_reader :id, :amount, :category_id, :merchant_id, :transaction_date

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @transaction_date = Date.parse(options['transaction_date'])
    @amount = options['amount'].to_i
    @category_id = options['category_id'].to_i
    @merchant_id = options['merchant_id'].to_i
  end

  def save()
    sql = "INSERT INTO transactions
    (
      transaction_date,
      amount,
      category_id,
      merchant_id
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING *;"
    values = [@transaction_date, @amount, @category_id, @merchant_id]
    results = SqlRunner.run( sql, values )
    @id = results.first['id'].to_i
  end

  def update()
    sql = "UPDATE transactions
          SET
          (
            transaction_date,
            amount,
            category_id,
            merchant_id
          ) =
          (
            $1, $2, $3, $4
          )
          WHERE id = $5;"
    values = [@transaction_date, @amount, @category_id, @merchant_id, @id]
    SqlRunner.run( sql, values )
  end

  def delete()
    sql = "DELETE FROM transactions
          WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
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

  def pretty_date()
    day = @transaction_date.mday().to_s.rjust(2, "0")
    month = @transaction_date.mon().to_s.rjust(2, "0")
    year = @transaction_date.year()
    return "#{day}/#{month}/#{year}"
  end

  def self.all()
    sql = "SELECT * FROM transactions
           ORDER BY transaction_date;"
    transactions = SqlRunner.run( sql )
    return transactions.map { |transaction| Transaction.new( transaction ) }
  end

  def self.delete_all()
    sql = "DELETE FROM transactions;"
    SqlRunner.run( sql )
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM transactions
          WHERE id = $1;"
    values = [id]
    transaction_hash = SqlRunner.run( sql, values ).first()
    return Transaction.new(transaction_hash)
  end

  def self.return_years()
    sql = "SELECT DISTINCT
           date_part('year', transaction_date) AS years
           FROM transactions;"
    years_hash = SqlRunner.run( sql )
    years = years_hash.map { |year_hash| year_hash['years'] }
    return years
  end

  def self.return_transactions_by_month(month, year)
    sql = "SELECT * FROM transactions
           WHERE date_part('month', transaction_date) = $1
           AND date_part('year', transaction_date) = $2;"
    values = [month, year]
    transaction_hash = SqlRunner.run( sql, values )
    return transaction_hash.map do
      |transaction_hash| Transaction.new(transaction_hash)
    end
  end

  def self.total_spent_month(month, year)
    sql = "SELECT SUM(amount)
           FROM transactions
           WHERE date_part('month', transaction_date) = $1
           AND date_part('year', transaction_date) = $2;"
    values = [month, year]
    total = SqlRunner.run( sql, values ).first()['sum']
    return total.to_i
  end

  def self.total_spent()
    sql = "SELECT SUM(amount)
           FROM transactions;"
    total = SqlRunner.run( sql ).first()['sum']
    return total.to_i
  end

  def self.number_of_months_spending()
    sql = "SELECT DISTINCT
           date_part('year', transaction_date) AS years,
           date_part('month', transaction_date) AS months
           FROM transactions;"
    months_years_hash = SqlRunner.run( sql )
    return months_years_hash.count
  end
end
