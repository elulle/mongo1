require 'sinatra'
require 'mongoid'
require 'json'

## Mongoid setup
## =============

Mongoid.load!("mongoid.yml")
     



class User
    include Mongoid::Document

    field :name
    field :email
end

## Sinatra app
## ===========

# display signup form
get '/' do
    erb :form
end

# add new user, display thanks
post '/' do
    name = params[:name]
    email = params[:email]
    @user = User.new(:name => name, :email => email)
    @user.save
    erb :thanks
end

# show all the users so far
get '/list' do
    @users = User.all
    erb :list
end