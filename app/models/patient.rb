class Patient < ApplicationRecord
	ransacker :age do
  		Arel.sql("to_char(\"#{table_name}\".\"age\", '99999999')")
	end
	belongs_to :user
end
