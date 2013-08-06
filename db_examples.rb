require 'mongoid'
require 'json'

Mongoid.load!("mongoid.yml", :development)

class User
    include Mongoid::Document

    field :name
    field :email
end


# How many users are there currently in the database
User.count


u = User.new(:name => "Tom", :email => 'tom@example.com')

u.save

u1 = User.first

User.count

User.all {|u| puts u.name}