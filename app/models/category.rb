class Category < ApplicationRecord
  belongs_to :survey
  has_many :questions, dependent: :destroy
  has_many :user_category_scores, dependent: :destroy
  
  validates :name, presence: true
end
