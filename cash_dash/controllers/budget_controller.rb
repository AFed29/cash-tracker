require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/budget.rb')
require_relative('../models/utilities.rb')

get '/budget' do
  budget = Utilities.display_pounds_pence(Budget.all().amount)
  budget[0] = ""
  @budget = budget
  @id = Budget.all().id
  erb( :"budget/index" )
end

post '/budget/:id' do
  params['amount'] = (params['amount'].to_f*100).to_i
  budget = Budget.new( params )
  budget.update()
  redirect to('/budget')
end
