# @file app/models/user.rb
# @description User model representing application users. Includes Devise modules for authentication.
# A user can respond to multiple surveys and have individual category scores.
# @version 1.0.0
# @author
#   - Athika Jishida

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :responses, dependent: :destroy
  has_many :user_category_scores, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
