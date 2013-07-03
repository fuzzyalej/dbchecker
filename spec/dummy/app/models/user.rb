class User < ActiveRecord::Base
  attr_accessible :name, :email, :number_of_logins
  has_one :profile
end
