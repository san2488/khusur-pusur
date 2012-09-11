class Post < ActiveRecord::Base
attr_accessible :content, :title, :category_id

  validates :title, :presence => true

  belongs_to :category
  belongs_to :user
  has_many :comments
  has_many :votes, :as=>:voteable
end
