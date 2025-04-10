# @file app/models/user_category_score.rb
# @description Represents the user's performance within a specific category of a survey.
# Calculates percentage and classifies performance into defined brackets.
# @version 1.0.0
# @author
#   - Athika Jishida
class UserCategoryScore < ApplicationRecord
  belongs_to :user
  belongs_to :survey
  belongs_to :category

  validates :total_score, :max_score, presence: true, numericality: { only_integer: true }
  validates :percentage, numericality: true, allow_nil: true

  before_save :calculate_percentage

  # Calculates the percentage score before saving
  def calculate_percentage
    self.percentage = (total_score.to_f / max_score) * 100 if max_score.positive?
  end

  # Classifies performance based on percentage
  def classification
    case percentage
    when 0...30 then 'Poor'
    when 30...60 then 'Average'
    when 60...80 then 'Good'
    else 'Very Proficient'
    end
  end
end
