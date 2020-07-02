class Patient < ApplicationRecord
	ransacker :age do
  		Arel.sql("to_char(\"#{table_name}\".\"age\", '99999999')")
	end
	
	belongs_to :user
	has_many :meetings

	validates :details, presence: true
	validates :age, :inclusion => {:in => 1...60,:message => "Age Should be Between 1 to 60"}
  	validates :name, :length => { :minimum => 4 ,:message => "The Patient Name Must be Minimum 4 Characters"}
  	validates :email, format: { with: /.*@.*/ }
  	resourcify
end
