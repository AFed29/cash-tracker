require('minitest/autorun')
require_relative('../models/merchant.rb')


class TestMerchant < MiniTest::Test

  def setup()
    @merchant1 = Merchant.new( {'name' => 'Tesco'} )
  end

  def test_check_merchant_has_name()
    assert_equal( "Tesco", @merchant1.name() )
  end
end
