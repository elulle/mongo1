require 'sinatra'
require 'mongoid'
require 'json'
require 'pony'

## Mongoid setup
## =============

Mongoid.load!("mongoid.yml")

class User
    include Mongoid::Document

    field :name
    field :email
end
## Email setup
## ===========

Pony.options = { 
  :via => 'smtp',
  :via_options => {
      :address              => 'smtp.gmail.com',
      :port                 => '587',
      :enable_starttls_auto => true,
      :user_name            => ENV['USER_NAME'],
      :password             => ENV['PASSWORD'],
      :authentication       => :login, # :plain, :login, :cram_md5, no auth by default
      :domain               => "localhost.localdomain", # the HELO domain provided by the client to the server
    :openssl_verify_mode  => 'none'
    }
  }
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
    Pony.mail(:to => email, :subject => "Sign up", :body => erb(:email, :layout => false))
    erb :thanks
end

# show all the users so far
get '/list' do
    @users = User.all
    erb :list
end