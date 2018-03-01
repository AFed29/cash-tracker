class Budget
  attr_reader :id, :amount
  def initialize( options )
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_i
  end

  def save()
    sql = "INSERT INTO budget
           (amount)
           VALUES
           ($1)
           RETURNING *;"
    values = [@amount]
    results = SqlRunner.run( sql, values )
    @id = results.first['id'].to_i
  end

  def update()
    sql = "UPDATE budget SET
           amount = $1
           WHERE id = $2;"
    values = [@amount, @id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM budget;"
    budget_hash = SqlRunner.run( sql ).first()
    return Budget.new(budget_hash)
  end

  def self.delete_all()
    sql = "DELETE FROM budget"
    SqlRunner.run( sql )
  end

end
