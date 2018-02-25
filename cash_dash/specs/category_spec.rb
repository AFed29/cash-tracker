require('minitest/autorun')
require_relative('../models/category.rb')


class TestCategory < MiniTest::Test

  def setup()
    @category1 = Category.new({'name' => 'groceries'})
  end

  def test_check_category_has_name()
    assert_equal("groceries", @category1.name())
  end

  def test_save_returns_id()
    @category1.save()
    assert(@category1.id != nil)
  end

end
