class Meeting < ApplicationRecord
  belongs_to :user
  belongs_to :patient

  validates :name, :length => { :minimum => 5 ,:message => "The Patient Name Must be Minimum 4 Characters" }
  validates :patient_id, presence: true
  
  validates_datetime :start_time, :after => lambda { DateTime.now }, :after_message => "Please Make the Appointment after Present Time i.e #{(DateTime.now).to_s}"
  validates_datetime :end_time, :after => :start_time
  resourcify
end
