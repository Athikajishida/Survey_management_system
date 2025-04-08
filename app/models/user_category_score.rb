class UserCategoryScore < ApplicationRecord
  belongs_to :user
  belongs_to :survey
  belongs_to :category
  
  validates :total_score, :max_score, presence: true, numericality: { only_integer: true }
  validates :percentage, numericality: true, allow_nil: true
  
  before_save :calculate_percentage
  
  def calculate_percentage
    self.percentage = (total_score.to_f / max_score) * 100 if max_score.positive?
  end
  
  def classification
    case percentage
    when 0...30
      'Poor'
    when 30...60
      'Average'
    when 60...80
      'Good'
    else
      'Very Proficient'
    end
  end
end
