class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_uniqueness_of :username
  validates_presence_of :username
end
