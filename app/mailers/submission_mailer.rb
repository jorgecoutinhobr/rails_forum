class SubmissionMailer < ApplicationMailer
  def new_response
    @submission = params[:submission]
    @comment = params[:comment]

    mail to: @submission.user.email, subject: "New response to your submission '#{@submission.title}'"
  end
end
