class Submission < ApplicationRecord
  extend FriendlyId
  include PgSearch::Model
  include VoteCountable

  multisearchable against: [:title, :body, :url]

  belongs_to :user
  belongs_to :community
  has_one_attached :media
  has_many :comments, dependent: :destroy
  validates :video_url, format: URI::regexp(%w[http https]), allow_blank: true

  validates :title ,presence: true
  validates :body, length: { maximum: 8000 }
  validates :url, url: true, allow_blank: true

  acts_as_votable

  friendly_id :title, use: :slugged

  def embedded_video
    return unless video_url.present? && video_url.include?("youtube.com") || video_url.include?("youtu.be")

    youtube_id = video_url.split("v=").last || video_url.split("/").last
    "https://www.youtube.com/embed/#{youtube_id}"
  end
end
