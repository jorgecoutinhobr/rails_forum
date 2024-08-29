class SubmissionsController < ApplicationController
  before_action :set_submission, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]
  def index
    @submissions = Submission.all
  end

  def show; end

  def new
    @submission = Submission.new
  end

  def edit; end

  def create
    @submission = Submission.new(submission_params)
    @submission.user_id = current_user.id

    if @submission.save
      redirect_to submission_url(@submission), notice: "Submission was successfully created."
    else
        render :new, status: :unprocessable_entity
    end
  end

  def update
    if @submission.update(submission_params)
      redirect_to submission_url(@submission), notice: "Submission was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @submission.destroy
    redirect_to submissions_url, notice: "Submission was successfully destroyed."
  end

  private
    def set_submission
      @submission = Submission.find(params[:id])
    end

    def submission_params
      params.require(:submission).permit(:title, :body, :url, :media)
    end
end
