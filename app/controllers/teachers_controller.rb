class TeachersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @teachers = Teacher.all
    respond_to do |format|
      format.json { render json: { teachers: @teachers }, status: :ok }
      format.html
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
    respond_to do |format|
      format.json { render json: { teacher: @teacher }, status: :ok }
      format.html
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
      format.html { render html: { error: e.message }, status: :not_found }
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def create
    @teacher = Teacher.create(teacher_params)
    if @teacher.save
      respond_to do |format|
        format.json { render json: { teacher: @teacher }, status: :ok }
        format.html { redirect_to :back }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @teacher.errors }, status: :unprocessable_entity }
        format.html { render html: { message: @teacher.errors.messages }, status: :unprocessable_entity }
      end
    end
  end

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update(teacher_params)
      respond_to do |format|
        format.json { render json: { teacher: @teacher }, status: :ok }
        format.html { redirect_to @teacher }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @teacher.errors }, status: :unprocessable_entity }
        format.html { render html: { message: @teacher.errors.messages }, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
      format.html { render html: { message: @teacher.errors.messages }, status: :unprocessable_entity }
    end
  end

  def destroy
    @teacher = Teacher.find(params[:id])
    @teacher.destroy
    respond_to do |format|
      format.json { render json: { message: 'Successfully deleted' }, status: :ok }
      format.html { redirect_to :back }
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
      format.html { redirect_to @teacher }
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:name, :subject_name, :salary, :school_id, :classroom_id, :subject_id, :student_ids)
  end
end
