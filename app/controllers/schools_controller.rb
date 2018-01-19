class SchoolsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @schools = School.all
    respond_to do |format|
      format.json { render json: { schools: @schools }, status: :ok }
      format.html
    end
  end

  def show
    @school = School.find(params[:id])
    respond_to do |format|
      format.json { render json: { school: @school }, status: :ok }
      format.html
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
      format.html
    end
  end

  def new
    @school = School.new
  end

  def edit
    @school = School.find(params[:id])
  end

  def create
    @school = School.new(school_params)
    if @school.save
      respond_to do |format|
        format.json { render json: { school: @school }, status: :ok }
        format.html { redirect_to @school }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @school.errors }, status: :unprocessable_entity }
        format.html { render 'new' }
      end
    end
  end

  def update
    @school = School.find(params[:id])
    if @school.update(school_params)
      respond_to do |format|
        format.html { redirect_to schools_path }
        format.json { render json: { school: @school }, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @school.errors }, status: :unprocessable_entity }
        format.html { render html: { error: @school.errors.messages }, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
      format.html { render html: { error: @school.errors.messages }, status: :not_found }
    end
  end

  def destroy
    @school = School.find(params[:id])
    @school.destroy
    respond_to do |format|
      format.json { render json: { message: 'Successfully deleted' }, status: :ok }
      format.html { redirect_to schools_path }
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
      format.html { redirect_to @school }
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :address, :phone_no)
  end
end
