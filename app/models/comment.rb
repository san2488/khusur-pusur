class Comment < ActiveRecord::Base
attr_accessible :content

  validates :content, :presence => true

  has_many :votes, :as=>:voteable, :dependent => :destroy
  belongs_to :post
  belongs_to :user
end
