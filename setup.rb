require "active_record"
require 'securerandom'

# Setup
ActiveRecord::Base.establish_connection("postgres://postgres:postgres@localhost:5442/demo")
ActiveRecord::Base.connection.drop_table(:users, if_exists: true)
ActiveRecord::Base.connection.create_table(:users) { |t| t.text :username, null: false, index: {unique: true} }
ActiveRecord::Base.logger = Logger.new(STDOUT)
class User < ActiveRecord::Base ; end

# Basic transaction
1000.times do 
  User.transaction do
    User.create(username: SecureRandom.hex)
  end
end
