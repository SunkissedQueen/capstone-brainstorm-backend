class Blocker < ApplicationRecord
  has_many :solutions
  has_many :users, through: :solutions
  validates :category, :blocker_description, presence: true
end
