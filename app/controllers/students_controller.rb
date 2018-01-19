class StudentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @students = Student.all
    respond_to do |format|
      format.json { render json: { students: @students }, status: :ok }
      format.html
    end
  end

  def show
    @student = Student.find(params[:id])
    respond_to do |format|
      format.json { render json: { student: @student }, status: :ok }
      format.html
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
      format.html { render html: { error: e.message }, status: :not_found }
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      respond_to do |format|
        format.json { render json: { student: @student }, status: :ok }
        format.html { redirect_to :back }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @student.errors }, status: :unprocessable_entity }
        format.html { render html: { message: @student.errors.messages }, status: :unprocessable_entity }
      end
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      respond_to do |format|
        format.json { render json: { student: @student }, status: :ok }
        format.html { redirect_to @student }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @student.errors }, status: :unprocessable_entity }
        format.html { render html: { message: @student.errors.messages }, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
      format.html { render html: { message: @student.errors.messages }, status: :not_found }
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    respond_to do |format|
      format.json { render json: { message: 'Successfully deleted' }, status: :ok }
      format.html { redirect_to :back }
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
      format.html { redirect_to @student }
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :address, :phone_no, :percentage, :school_id, :classroom_id, :subject_ids, :teacher_ids)
  end
end
