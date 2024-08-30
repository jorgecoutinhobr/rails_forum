class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :submissions, dependent: :destroy
  has_many :communities
  has_many :comments, dependent: :destroy
  has_many :subscriptions
  has_many :communities, through: :subscriptions
  has_many :subscribed_submissions, through: :communities, source: :submissions

  validates_uniqueness_of :username
  validates_presence_of :username

  acts_as_voter
end
