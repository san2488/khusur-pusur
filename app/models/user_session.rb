#http://www.robertsosinski.com/2008/02/23/simple-and-restful-authentication-for-ruby-on-rails/
class UserSession < ActiveRecord::Base
  attr_accessor :email, :password, :match
  attr_accessible :email, :password, :ip_address, :path
  belongs_to :user
  before_validation :authenticate_user

  validates_presence_of :match,
                        :message => 'for your name and password could not be found',
                        :unless => :user_session_has_been_associated?

  before_save :associate_user_session_to_user

  private

  def authenticate_user
    unless user_session_has_been_associated?
      self.match = User.find_by_email_and_password(self.email, self.password)
    end
  end

  def associate_user_session_to_user
    self.user_id ||= self.match.id
  end

  def user_session_has_been_associated?
    self.user_id
  end
end
