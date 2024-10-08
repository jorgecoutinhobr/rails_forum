class ProfilesController < ApplicationController
  def show
    @profile = User.friendly.find(params[:id])
    @submissions = @profile.submissions.order(created_at: :desc)
    @comments = @profile.comments.order(created_at: :desc)
  end
end
