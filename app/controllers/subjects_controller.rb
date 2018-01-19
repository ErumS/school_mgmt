class SubjectsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @subjects = Subject.all
    respond_to do |format|
      format.json { render json: { subjects: @subjects }, status: :ok }
      format.html
    end
  end

  def show
    @subject = Subject.find(params[:id])
    respond_to do |format|
      format.json { render json: { subject: @subject }, status: :ok }
      format.html
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
      format.html { render html: { error: e.message }, status: :not_found }
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def create
    @subject = Subject.create(subject_params)
    if @subject.save
      respond_to do |format|
        format.json { render json: { subject: @subject }, status: :ok }
        format.html { redirect_to :back }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @subject.errors }, status: :unprocessable_entity }
        format.html { render html: { message: @subject.errors.messages }, status: :unprocessable_entity }
      end
    end
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
      respond_to do |format|
        format.json { render json: { subject: @subject }, status: :ok }
        format.html { redirect_to @subject }
      end
    else
      respond_to do |format|
        format.json { render json: { error: @subject.errors }, status: :unprocessable_entity }
        format.html { render html: { message: @subject.errors.messages }, status: :unprocessable_entity }
      end
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
      format.html { render html: { message: @subject.errors.messages }, status: :not_found }
    end
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    respond_to do |format|
      format.json { render json: { message: 'Successfully deleted' }, status: :ok }
      format.html { redirect_to :back }
    end
  rescue StandardError => e
    respond_to do |format|
      format.json { render json: { error: e.message }, status: :not_found }
      format.html { redirect_to @subject }
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :subject_duration, :school_id, :student_ids)
  end
end
