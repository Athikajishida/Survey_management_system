# @file app/models/survey.rb
# @description Represents a survey that contains categories and questions.
# A survey can have multiple user responses.
# @version 1.0.0
# @author
#   - Athika Jishida
class Survey < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :questions, through: :categories
  has_many :responses, dependent: :destroy
  
  validates :title, presence: true
end
