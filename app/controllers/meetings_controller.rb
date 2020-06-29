class MeetingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  # GET /meetings
  # GET /meetings.json
  def index
    if current_user.has_role? :admin or current_user.has_role? :nurse
      @search= Meeting.search(params[:q])
      if @search.result
        @meetings=@search.result.paginate(:page => params[:page],:per_page => 5)
      else
        @meetings=Meeting.order("created_at DESC").paginate(:page => params[:page],:per_page => 5)
      end
    elsif current_user.has_role? :doctor
      @search= current_user.meetings.search(params[:q])
      if @search.result
        @meetings=@search.result.paginate(:page => params[:page],:per_page => 5)
      else
        @meetings=current_user.meetings.order("created_at DESC").paginate(:page => params[:page],:per_page => 5)
      end
  end
end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = current_user.meetings.new
    if current_user.has_role? :admin 
      @user_meeting=Meeting.all.paginate(:page => params[:page],:per_page => 8)
    elsif current_user.has_role? :doctor
      @user_meeting=current_user.meetings.all.paginate(:page => params[:page],:per_page => 8)
    end
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = current_user.meetings.new(meeting_params)
    @meeting.user_id=current_user.id
      if @meeting.save
        redirect_to meetings_path, notice: 'Meeting was successfully created.'
      else
        redirect_to new_meeting_path , alert: "Please fill all the details"
      end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:name, :start_time, :end_time, :user_id, :patient_id)
    end
end
