require 'sinatra'
require 'mongoid'
require 'pony'
require 'json'

## Mongoid setup
## =============

Mongoid.load!("mongoid.yml", :development)

class Fruit
  include Mongoid::Document

  field :name
end

## Email setup
## ===========

Pony.options = { :via => 'smtp',
                 :via_options => {
                                :address              => 'smtp.gmail.com',
                                :port                 => '587',
                                :enable_starttls_auto => true,
                                :user_name            => ENV['USER_NAME'],
                                :password             => ENV['PASSWORD'],
                                :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
                                :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server

                 }
                }


## Sinatra app
## ===========

get '/' do
  @fruits = Fruit.all 
  erb :index
end

post '/' do
  name = params[:fruit_name]
  email = params[:email]
  f = Fruit.new(:name => name)
  f.save
  Pony.mail(:to => email, :subject => "Congratulations, you added a fruit!", :body => "#{name} is a great fruit.")
  @fruits = Fruit.all
  erb :index
end