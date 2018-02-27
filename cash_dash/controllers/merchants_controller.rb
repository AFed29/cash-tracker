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

get '/merchants/:id/delete/error' do
  @merchant = Merchant.find_by_id( params['id'] )
  erb( :"/merchants/delete_error")
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

post '/merchants/:id/delete' do
  if Merchant.check_if_exists_in_transaction( params['id'] )
    redirect to("/merchants/#{params['id']}/delete/error")
  else
    merchant = Merchant.find_by_id( params['id'] )
    merchant.delete()
    redirect to("/merchants")
  end
end
