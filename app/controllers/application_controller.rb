class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	def route
		if current_user.has_role?(:admin) or current_user.has_role?(:doctor)
			redirect_to patients_path
		elsif current_user.has_role?(:nurse)
			redirect_to meetings_path
		else
			redirect_to meetings_path
		end
	end
end
