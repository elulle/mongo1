require 'sinatra'
require 'mongoid'
require 'json'

## Mongoid setup
## =============

Mongoid.load!("mongoid.yml", :development)

class Fruit
  include Mongoid::Document

  field :name
end

## Sinatra app
## ===========

get '/' do
  @fruits = Fruit.all 
  erb :index
end

post '/' do
  name = params[:fruit_name]
  f = Fruit.new(:name => name)
  f.save
  @fruits = Fruit.all
  erb :index
end