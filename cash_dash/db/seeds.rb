require_relative('../models/category.rb')
require_relative('../models/merchant.rb')
require_relative('../models/transaction.rb')
require('pry-byebug')

Transaction.delete_all()
Merchant.delete_all()
Category.delete_all()

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


merchant1 = Merchant.new({
  "name" => "peppers"
})
merchant1.save()

merchant2 = Merchant.new({
  "name" => "tesco"
})
merchant2.save()

transaction1 = Transaction.new({
  "amount" => 600,
  "merchant_id" => merchant1.id(),
  "category_id" => category3.id()
})
transaction1.save()

transaction2 = Transaction.new({
  "amount" => 1205,
  "merchant_id" => merchant2.id(),
  "category_id" => category1.id()
})
transaction2.save()

transaction2 = Transaction.new({
  "amount" => 420,
  "merchant_id" => merchant2.id(),
  "category_id" => category1.id()
})
transaction2.save()

  binding.pry

  nil
