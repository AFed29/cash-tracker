require_relative('../models/category.rb')
require_relative('../models/merchant.rb')
require_relative('../models/transaction.rb')
require_relative('../models/budget.rb')
require('pry-byebug')

Transaction.delete_all()
Merchant.delete_all()
Category.delete_all()
Budget.delete_all()

category1 = Category.new({
  "name" => "groceries"
})
category1.save()

category2 = Category.new({
  "name" => "entertainment"
})
category2.save()

category3 = Category.new({
  "name" => "eating out"
})
category3.save()

category4 = Category.new({
  "name" => "bills"
})
category4.save()

category5 = Category.new({
  "name" => "transport"
})
category5.save()

category6 = Category.new({
  "name" => "holidays"
})
category6.save()

category7 = Category.new({
  "name" => "general"
})
category7.save()

category8 = Category.new({
  "name" => "clothing"
})
category8.save()

merchant1 = Merchant.new({
  "name" => "peppers"
})
merchant1.save()

merchant2 = Merchant.new({
  "name" => "tesco"
})
merchant2.save()

transaction1 = Transaction.new({
  "transaction_date" => "2018/01/25",
  "amount" => 600,
  "merchant_id" => merchant1.id(),
  "category_id" => category3.id()
})
transaction1.save()

transaction2 = Transaction.new({
  "transaction_date" => "2017/12/10",
  "amount" => 1205,
  "merchant_id" => merchant2.id(),
  "category_id" => category1.id()
})
transaction2.save()

transaction3 = Transaction.new({
  "transaction_date" => "2018/01/19",
  "amount" => 420,
  "merchant_id" => merchant2.id(),
  "category_id" => category1.id()
})
transaction3.save()

budget = Budget.new({
  'amount' => 150000
  })
budget.save()

  binding.pry

  nil
