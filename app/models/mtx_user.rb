class MtxUser < ActiveRecord::Base
    self.table_name = 'mtx_user'

    self.inheritance_column = :ruby_type
    has_many :mtx_order, :class_name => 'MtxOrder'

    attr_accessor :password_confirmation
    validates :fullname,  presence: true, length: { maximum: 50 }
    validates :username,  presence: true, length: { maximum: 50 }, uniqueness: true
    validates :password, presence: true, length: { minimum: 6, maximum: 50 }, :confirmation => true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
              format: { with: VALID_EMAIL_REGEX }, uniqueness: true
end
