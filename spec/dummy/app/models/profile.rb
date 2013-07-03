class Profile < ActiveRecord::Base
  attr_accessible :url, :bio, :number_of_friends, :number_of_points
  belongs_to :user
  belongs_to :provider
end
