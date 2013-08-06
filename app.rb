require 'sinatra'
require 'mongoid'
require 'json'

## Mongoid setup
## =============

configure do
    Mongoid.configure do |config|
       if ENV['MONGOHQ_URL']
        conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
        uri = URI.parse(ENV['MONGOHQ_URL'])
        config.master = conn.db(uri.path.gsub(/^\//, ''))
      else
        Mongoid.load!("mongoid.yml", :development)
      end
    end
end



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