require 'mongoid'
require 'json'

Mongoid.load!("mongoid.yml", :development)

class User
    include Mongoid::Document

    field :name
    field :email
end


### Create a new user

u1 = User.new(:name => "Tom", :email => 'tom@example.com')

# get the properties
u1.name
u1.email

# change the name
u1.name = "Tom Close"

# check the name has changed
u1.name

# save the user to the database
u1.save

# TODO: create another two users

### Using the database
# ====================

# To find out about what's in the database, we use methods of User

# How many users are there currently in the database
User.count

# find the first user
u2 = User.first

# check the properties
u2.name
u2.email

# find a specific user
u3 = User.find_by(:name => "Tom Close")

# pull all users out of the database
users = User.all

# print out their names
users.each {|u| puts u.name}