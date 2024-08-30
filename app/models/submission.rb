class Submission < ApplicationRecord
  include VoteCountable
  belongs_to :user
  belongs_to :community
  has_one_attached :media
  has_many :comments, dependent: :destroy

  validates :title ,presence: true
  validates :body, length: { maximum: 8000 }
  validates :url, url: true, allow_blank: true

  acts_as_votable
end
