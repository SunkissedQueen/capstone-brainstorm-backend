class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_many :solutions
  has_many :blockers, through: :solutions
  validates :username, :email, presence: true
  validates :password, presence: true, confirmation: true
end
