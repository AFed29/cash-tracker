require('minitest/autorun')
require_relative('../models/utilities.rb')

class TestUtilities < MiniTest::Test
  def test_pretty_display_total()
    result = Utilities.display_pounds_pence(6273)
    assert_equal("£62.73", result)
  end
end
