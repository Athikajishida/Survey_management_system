class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :responses, dependent: :destroy
  has_many :user_category_scores, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
end
