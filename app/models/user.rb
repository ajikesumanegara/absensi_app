class User < ApplicationRecord
  belongs_to :company, optional: true
  has_many :attendances
  before_save { self.email = email.downcase }
  
  validates :username, presence: true, 
                    uniqueness: { case_sensitive: false }, 
                    length: { minimum: 6, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  validates :full_name, presence: true, length: { minimum: 2, maximum: 25 }

  has_secure_password
end