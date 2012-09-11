class User < ActiveRecord::Base
  attr_accessible :is_admin, :name, :password

  has_many :votes
  has_many :comments
  has_many :posts
end
