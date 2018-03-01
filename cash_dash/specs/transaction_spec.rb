require('minitest/autorun')
require_relative('../models/transaction.rb')

class TestTransaction < MiniTest::Test

  def setup
    @transaction1 = Transaction.new( {'amount' => 550} )
  end

  def test_transaction_has_amount()
    assert_equal( 550, @transaction1.amount() )
  end


end
