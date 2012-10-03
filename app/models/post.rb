class Post < ActiveRecord::Base
attr_accessible :content, :title, :category_id

  validates :title, :presence => true
  validates :content, :presence => true
  #validates :category_id, :presence => true

  belongs_to :category
  belongs_to :user
  has_many :comments , :dependent => :destroy
  has_many :votes, :as=>:voteable, :dependent => :destroy



  #http://railscasts.com/episodes/37-simple-search-form
  def self.search(type, search)
    case
      when type == "user"
        users = User.all(:conditions => ['name LIKE ?', "%#{search}%"])
        if users
        Post.find_all_by_user_id(users)
        else
          Array.new
          end
      when type == "content"
        Post.all(:conditions => ['content LIKE ?', "%#{search}%"])
      when type == "category"
        category = Category.first(:conditions => ['name LIKE ?', "%#{search}%"])
        if category
        Post.find_all_by_category_id(category.id)
        else
          Array.new
          end
      else
        Post.all
    end

  end
end
