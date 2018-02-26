require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/merchant.rb')

get '/merchants' do
  @merchants = Merchant.all()
  erb( :"/merchants/index" )
end

get '/merchants/:id/edit' do
  @merchant = Merchant.find_by_id( params['id'] )
  erb( :"/merchants/edit")
end

post '/merchants' do
  merchant = Merchant.new( params )
  merchant.save()
  redirect to("/merchants")
end

post '/merchants/:id' do
  merchant = Merchant.new( params )
  merchant.update()
  redirect to("/merchants")
end
