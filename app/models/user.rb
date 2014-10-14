class User < ActiveRecord::Base
  has_secure_password
  has_many :transactions
  has_many :marketposts, dependent: :destroy

  validates :password, presence: true, length: { minimum: 6 }, on: :create

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :name, presence: true, length: { maximum: 50 }

  attr_accessible :email, :name, :password, :password_confirmation
  
  after_validation { self.errors.messages.delete(:password_digest) }
end
