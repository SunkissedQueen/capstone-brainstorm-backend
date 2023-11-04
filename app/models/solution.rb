class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :blocker
  validates :description, :user_id, :blocker_id, presence: true
end
