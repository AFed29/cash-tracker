require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/merchants_controller.rb')
require_relative('controllers/transactions_controller.rb')
require_relative('controllers/categories_controller.rb')
require_relative('controllers/budget_controller.rb')

get '/' do
  erb( :index )
end
