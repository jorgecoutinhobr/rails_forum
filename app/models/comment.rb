class Comment < ApplicationRecord
  include PgSearch::Model
  include VoteCountable

  multisearchable against: :reply

  belongs_to :submission
  belongs_to :user

  validates :reply, presence: true

  acts_as_votable
  # after_create_commit { broadcast_append_to submission }
  # after_update_commit { broadcast_replace_to submission }
  # after_destroy_commit { broadcast_remove_to submission }
end
