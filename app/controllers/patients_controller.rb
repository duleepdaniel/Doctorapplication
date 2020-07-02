class PatientsController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource

	def index
		if current_user.has_role? :admin or current_user.has_role? :nurse
			@search= Patient.search(params[:q])
			if @search.result
				@patients=@search.result.paginate(:page => params[:page],:per_page => 2)
			else
				@patients=Patient.all.order("created_at DESC").paginate(:page => params[:page],:per_page => 2)			
			end
		elsif current_user.has_role? :doctor
			@search= current_user.patients.search(params[:q])
			if @search.result
				@patients=@search.result.paginate(:page => params[:page],:per_page => 8)
			else
				@patients=current_user.patients.order("created_at DESC").paginate(:page => params[:page],:per_page => 8)
			end
		end		
	end

	def new
		if current_user.has_role? :admin 
			@patient = Patient.new
			@user_patient=Patient.all.paginate(:page => params[:page],:per_page => 8)
		elsif current_user.has_role? :doctor
			@patient = current_user.patients.new
			@user_patient=current_user.patients.all.paginate(:page => params[:page],:per_page => 8)
		end
	end

	def create
		if current_user.has_role? :admin 
			@patient=Patient.new(patient_params)
		elsif current_user.has_role? :doctor
			@patient=current_user.patients.new(patient_params)
		end
      	if @patient.save
        	redirect_to patients_path, notice: 'Patient was successfully created.'
     	else
     		redirect_to new_patient_path,alert: @patient.errors
    	end
	end

	def destroy
		@patient=Patient.destroy(params[:id])
    	respond_to do |format|
      format.html { redirect_to patients_path, notice: 'Patient was successfully destroyed.' }
    	end
	end

	def edit
		@patient = Patient.find(params[:id])
	end

	def update
		@patient = Patient.find(params[:id])
		respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to patients_path, notice: 'Patient was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
	end


	private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:name, :age, :email, :address, :details ,:date,:user_id)
    end
end
