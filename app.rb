require 'sinatra'
require 'mongoid'
require 'json'

## Mongoid setup
## =============

Mongoid.load!("mongoid.yml", :development)

class User
    include Mongoid::Document

    field :name
    field :email
end

## Sinatra app
## ===========

# display form
get '/' do
    
end

# add new user, display thanks
post '/' do

end

# show all the users so far
get '/list' do
end