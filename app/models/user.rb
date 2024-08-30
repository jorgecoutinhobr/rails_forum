class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :submissions, dependent: :destroy
  has_many :communities
  has_many :comments, dependent: :destroy

  validates_uniqueness_of :username
  validates_presence_of :username
end
