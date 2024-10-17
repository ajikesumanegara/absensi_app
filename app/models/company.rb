class Company < ApplicationRecord
  has_many :users
  has_many :attendances
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 25 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
