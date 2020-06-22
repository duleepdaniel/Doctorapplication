class PatientsController < ApplicationController
	before_action :authenticate_user!

	def index
		@search= current_user.patients.search(params[:q])
		if @search.result
			@patient=@search.result.paginate(:page => params[:page],:per_page => 5)
		else
			@patient=current_user.patients.order("created_at DESC").paginate(:page => params[:page],:per_page => 5)
		end
	end

	def new
		@user_patient=current_user.patients.all
		@patient = Patient.new

	end

	def create
		@patient=current_user.patients.new(patient_params)
      if @patient.save
        redirect_to patients_path
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
      params.require(:patient).permit(:name, :age, :email, :address, :details ,:date)
    end
end
