class Answer < ApplicationRecord
  belongs_to :question
  has_many :response_details
  
  validates :text, :score, presence: true
  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
