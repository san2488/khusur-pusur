require 'digest/sha2'

class User < ActiveRecord::Base
  attr_reader :password
  attr_accessible :name, :email, :password, :password_confirmation, :is_admin
  ENCRYPT = Digest::SHA2

  has_many :user_sessions, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy

  validates :name, :presence =>true
  validates_uniqueness_of :email, :message => "is already in use by another person"
  #
  validates_format_of :email, :with => /^.+@.+$/i,
                      :message => "must be of the form example@site.com"

  validates_format_of :password, :with => /^([\x20-\x7E]){4,16}$/,
                      :message => "must be 4 to 16 characters",
                      :unless => :password_is_not_being_updated?

  validates_confirmation_of :password

  before_save :scrub_name #, :encrypt_password
  after_save :flush_passwords

  def self.find_by_email_and_password(email, password)
    user = self.find_by_email(email)
    if user and user.encrypted_password == ENCRYPT.hexdigest(password+ user.salt)
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

  #http://rubysource.com/rails-userpassword-authentication-from-scratch-part-i/
  def encrypt_password
    if encrypted_password.present?
      self.salt = [Array.new(9){rand(256).chr}.join].pack('m').chomp
      self.encrypted_password= ENCRYPT.hexdigest(password + self.salt)
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