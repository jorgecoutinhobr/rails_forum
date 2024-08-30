class CommentsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy, :show, :upvote, :downvote]
  before_action :set_submission

  def new; end

  def create
    @comment = @submission.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to submission_path(@submission), notice: "Comment created" }
      else
        format.turbo_stream
        format.html { redirect_to submission_path(@submission), alert: "Comment not created" }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream
        format.html { redirect_to submission_path(@submission), notice: "Comment create successfully" }
      else
        format.turbo_stream
        format.html { redirect_to submission_path(@submission), alert: "Comment could not be created." }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to submissions_path(@submission) }
    end
  end

  def upvote
    respond_to do |format|
      unless current_user.voted_for? @comment
        @comment.upvote_by current_user
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{dom_id(@comment)}_votes_count", @comment.total_vote_count)
      }
      else
        format.html { redirect_to submission_path(@submission), alert: "You already voted for this submission."}
      end
    end
  end

  def downvote
    respond_to do |format|
      unless current_user.voted_for? @comment
        @comment.downvote_by current_user
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{dom_id(@comment)}_votes_count", @comment.total_vote_count)
      }
      else
        format.html { redirect_to submission_path(@submission), alert: "You already voted for this submission."}
      end
    end
  end

  private
    def set_submission
      @submission = Submission.find(params[:submission_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:reply, :submission_id)
    end
end
