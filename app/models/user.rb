class User < ApplicationRecord
  has_many :responses, dependent: :destroy
  has_many :user_category_scores, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
end
