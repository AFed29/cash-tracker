require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/transaction.rb')
require_relative('../models/category.rb')
require_relative('../models/merchant.rb')

get '/transactions' do
  @transactions = Transaction.all()
  erb( :"transactions/index" )
end
