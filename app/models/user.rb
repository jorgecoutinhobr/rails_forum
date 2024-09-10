class User < ApplicationRecord
  extend FriendlyId
  include PgSearch::Model

  multisearchable against: :username

  before_create :add_unsubscribe_hash

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :submissions, dependent: :destroy
  has_many :communities
  has_many :comments, dependent: :destroy
  has_many :subscriptions
  has_many :communities, through: :subscriptions
  has_many :subscribed_submissions, through: :communities, source: :submissions
  has_many :premium_subscriptions, dependent: :destroy

  validates_uniqueness_of :username
  validates_presence_of :username

  acts_as_voter

  friendly_id :username, use: :slugged

  def subscribed?
    premium_subscriptions.where(status: 'active').any?
  end

  private
    def add_unsubscribe_hash
      self.unsubscribe_hash = SecureRandom.hex
    end
end
