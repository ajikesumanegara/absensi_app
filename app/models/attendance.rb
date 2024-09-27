class Attendance < ApplicationRecord
  include Attachable

  belongs_to :user
  belongs_to :company

  enum :status, { present: 1, sick: 2, leave: 3, leave_early: 4 }

  has_one_attached :selfie

  validates :clock_in, presence: true, on: :clock_in_time
  validates :status, presence: true, on: :permission_details
  validates :details, presence: true, on: :permission_details
  validates :selfie_url, presence: true, on: :clock_in_time
  validates :latitude, presence: true, on: :clock_in_time
  validates :longitude, presence: true, on: :clock_in_time

  def self.ransackable_attributes(auth_object = nil)
    ["clock_in", "clock_out", "created_at", "details", "id", "latitude", "longitude", "selfie_url", "status", "updated_at", "user_id"]
  end

end