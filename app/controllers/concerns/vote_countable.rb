require "active_support/concern"

module VoteCountable
  extend ActiveSupport::Concern

  included do
    def total_vote_count
      get_upvotes.size - get_downvotes.size
    end
  end
end
