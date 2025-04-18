# @file app/models/question.rb
# @description : Represents a question in a category, includes metadata like type and position.
# A question can have multiple answers and be associated with tags.
# @version 1.0.0
# @author
#   - Athika Jishida
class Question < ApplicationRecord
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags
  has_many :response_details
  
  validates :text, :question_type, :position, presence: true
end
