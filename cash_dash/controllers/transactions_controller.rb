require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/transaction.rb')
require_relative('../models/category.rb')
require_relative('../models/merchant.rb')

get '/transactions' do
  @transactions = Transaction.all()
  erb( :"transactions/index" )
end

get '/transactions/new' do
  @merchants = Merchant.all()
  @categories = Category.all()
  erb( :"transactions/new" )
end

get '/transactions/total' do
  @total_pounds = Transaction.total_spent_display_pounds()
  @total_pence = Transaction.total_spent_display_pence()
  erb( :"transactions/total_spent")
end

post '/transactions' do
  params[:amount] = (params[:amount].to_f*100).to_i
  transaction = Transaction.new(params)
  transaction.save()
  redirect to("/transactions")
end
