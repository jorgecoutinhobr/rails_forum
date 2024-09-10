module SubmissionsHelper
  def inject_feed_ad(index)
    return if user_signed_in? && current_user.subscribed?
    render partial: "application/feed_ad" if index.even? && index != 0
  end
end
