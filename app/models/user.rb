class User < ApplicationRecord
  belongs_to :company, optional: true
  has_many :attendances
  before_save { self.email = email.downcase }
  has_secure_password
  
  validates :username, presence: true, 
                    uniqueness: { case_sensitive: false }, 
                    length: { minimum: 6, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  validates :full_name, presence: true, length: { minimum: 2, maximum: 25 }
  
  validates_presence_of :password, :password_confirmation, :if => :password_required?
  validates_length_of :password, :password_confirmation, minimum: 6, :if => :password_required?

  def password_required?
    @password_required
  end

  def password_required!
    @password_required = true
  end

  def self.ransackable_attributes(auth_object = nil)
    ["as_admin", "as_owner", "company_id", "created_at", "email", "full_name", "id", "invite_token", "invite_token_expired_at", "password_confirmation", "password_digest", "reset_password_token", "reset_password_token_expired_at", "updated_at", "username"]
  end

  def companies_attributes=(companies_attributes)
    companies_attributes.each do |i, company_attributes|
      self.companies.build(company_attributes)
    end
  end
end