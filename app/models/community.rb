class Community < ApplicationRecord
  extend FriendlyId
  include PgSearch::Model

  multisearchable against: [:title, :name]

  belongs_to :user
  has_many :submissions
  has_many :subscriptions
  has_many :users, through: :subscriptions

  validates_associated :submissions

  friendly_id :title, use: :slugged
end
