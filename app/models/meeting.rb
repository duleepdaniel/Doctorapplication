class Meeting < ApplicationRecord
  belongs_to :user
  belongs_to :patient

  validates :name, length: { minimum: 5 }
  validates :patient_id, presence: true
  resourcify
end
