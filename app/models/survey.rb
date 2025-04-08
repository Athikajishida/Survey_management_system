class Survey < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :questions, through: :categories
  has_many :responses, dependent: :destroy
  
  validates :title, presence: true
end
