class Vote < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :voteable, :polymorphic => true
  belongs_to :user
end
