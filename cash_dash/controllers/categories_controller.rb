require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/category.rb')
require_relative('../models/transaction.rb')

get '/categories' do
  @categories = Category.all()
  erb( :"categories/index")
end
