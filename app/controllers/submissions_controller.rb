class SubmissionsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_submission, only: %i[ show edit update destroy upvote downvote ]
  before_action :authenticate_user!, except: %i[ index show unsubscribe ]
  def index
    if user_signed_in?
      @feed_title = "My Feed"
      @pagy, @submissions = pagy(current_user.subscribed_submissions, items: 15)
    else
      @feed_title = "Select a community"
      @submissions = Submission.all
    end
  end

  def show
    @community = @submission.community
    @subscription = @community.subscriptions.where(user: current_user).first
  end

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

  def upvote
    respond_to do |format|
      unless current_user.voted_for? @submission
        @submission.upvote_by current_user
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{dom_id(@submission)}_votes_count", @submission.total_vote_count)
      }
      else
         format.html { redirect_back fallback_location: root_path, alert: "You already voted for this submission."}
      end
    end
  end

  def downvote
    respond_to do |format|
      unless current_user.voted_for? @submission
        @submission.downvote_by current_user
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{dom_id(@submission)}_votes_count", @submission.total_vote_count)
      }
      else
        format.html { redirect_back fallback_location: root_path, alert: "You already voted for this submission."}
      end
    end
  end

  def unsubscribe
    user = User.find_by_unsubscribe_hash(params[:unsubscribe_hash])
    user.update(comment_subscription: false)
  end

  private
    def set_submission
      @submission = Submission.friendly.find(params[:id])
    end

    def submission_params
      params.require(:submission).permit(:title, :body, :url, :media, :community_id, :video_url)
    end
end
