require 'bcrypt'
class MtxUser < ActiveRecord::Base
  self.table_name = 'mtx_user'
  self.inheritance_column = :ruby_type
  before_save :encrypt_password
  has_many :mtx_order, :class_name => 'MtxOrder'

  attr_accessor :password_confirmation, :password
  validates :fullname, presence: true, length: {maximum: 255}
  validates :username, presence: true, length: {maximum: 25}, uniqueness: true
  validates :password, presence: true, length: {minimum: 6, maximum: 255}, :confirmation => true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX}, uniqueness: true

  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(self.password, self.password_salt)
  end

  def self.authenticate(user_name, password)
    user = MtxUser.find_by_username(user_name)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
