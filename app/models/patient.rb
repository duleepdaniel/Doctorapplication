class Patient < ApplicationRecord
	ransacker :age do
  		Arel.sql("to_char(\"#{table_name}\".\"age\", '99999999')")
	end
	
	belongs_to :user
	has_many :meetings

	validates :details, presence: true
	validates :age, inclusion: 1...60
  	validates :name, length: { minimum: 4 }
  	validates :email, format: { with: /.*@.*/ }
  	resourcify
end
