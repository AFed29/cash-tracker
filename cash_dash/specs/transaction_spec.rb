require('minitest/autorun')
require_relative('../models/transaction.rb')

class TestTransaction < MiniTest::Test

  def setup
    @transaction1 = Transaction.new( {'amount' => 550} )
  end

  def test_transaction_has_amount()
    assert_equal( 550, @transaction1.amount() )
  end

  def test_amount_pounds()
    result = @transaction1.amount_pounds()
    assert_equal( 5, result )
  end

  def test_amount_pence()
    result = @transaction1.amount_pence()
    assert_equal( 50, result )
  end

end
