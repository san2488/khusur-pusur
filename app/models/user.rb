require 'digest/sha2'

class User < ActiveRecord::Base
  #attr_reader :password
  attr_accessible :name, :email, :password, :password_confirmation
  ENCRYPT = Digest::SHA2

  has_many :user_sessions, :dependent => :destroy

  validates_uniqueness_of :email, :message => "is already in use by another person"
  #
  validates_format_of :email, :with => /^([a-z0-9_]{2,16})$/i,
                      :message => "must be 4 to 16 letters, numbers or underscores and have no spaces"

  validates_format_of :password, :with => /^([\x20-\x7E]){4,16}$/,
                      :message => "must be 4 to 16 characters",
                      :unless => :password_is_not_being_updated?

  validates_confirmation_of :password

  before_save :scrub_name
  after_save :flush_passwords

  def self.find_by_email_and_password(email, password)
    user = self.find_by_email(email)
    if user and user.encrypted_password == ENCRYPT.hexdigest(password + user.salt)
      return user
    end
  end

  def password=(password)
    @password = password
    unless password_is_not_being_updated?
      self.salt = [Array.new(9){rand(256).chr}.join].pack('m').chomp
      self.encrypted_password = ENCRYPT.hexdigest(password + self.salt)
    end
  end

  def scrub_name
    self.name.downcase!
  end

  def flush_passwords
    @password = @password_confirmation = nil
  end

  def password_is_not_being_updated?
    self.id and self.password.blank?
  end
end