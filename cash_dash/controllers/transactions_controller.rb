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
  total = Transaction.total_spent()
  @pretty_total = Transaction.display_pounds_pence(total)
  erb( :"transactions/total_spent")
end

get '/transactions/:id/edit' do
  @merchants = Merchant.all()
  @categories = Category.all()
  @transaction = Transaction.find_by_id( params['id'] )
  @pretty_total = Transaction.display_pounds_pence( @transaction.amount.to_i )
  @pretty_total[0] = ""
  erb( :"transactions/edit")
end

post '/transactions' do
  params['amount'] = (params['amount'].to_f*100).to_i
  transaction = Transaction.new(params)
  transaction.save()
  redirect to("/transactions")
end

post '/transactions/:id/delete' do
  transaction = Transaction.find_by_id( params['id'] )
  transaction.delete()
  redirect to("/transactions")
end

post '/transactions/:id' do
  params['amount'] = (params['amount'].to_f*100).to_i
  transaction = Transaction.new(params)
  transaction.update()
  redirect to("/transactions")
end
